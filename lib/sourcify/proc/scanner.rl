Sourcify.require_rb('proc', 'scanner', 'extensions')

module Sourcify
  module Proc
    module Scanner #:nodoc:all

%%{
  machine proc_scanner;

  kw_class  = 'class';
  kw_module = 'module';
  kw_def    = 'def';
  kw_begin  = 'begin';
  kw_case   = 'case';
  kw_if     = 'if';
  kw_unless = 'unless';
  kw_do     = 'do';
  kw_then   = 'then';
  kw_for    = 'for';
  kw_while  = 'while';
  kw_until  = 'until';
  kw_end    = 'end';

  const   = upper . (alnum | '_')* . ('::' . upper . (alnum | '_')*)*;
  var     = (lower | '_') . (alnum | '_')*;
  symbol  = ':' . (var | const);
  assoc   = '=>';
  assgn   = '=';
  comma   = ',';
  label   = (var | const) . ':';

  lparen  = '(';
  rparen  = ')';
  lbrace  = '{';
  rbrace  = '}';
  smcolon = ';';
  newline = '\n';
  ospaces = space* -- newline;
  mspaces = space+ -- newline;

  ## MACHINE >> New statement
  new_statement := |*

    kw_for | kw_while | kw_until => {
      push(:kw_do_alias2, ts, te)
      increment_counter(:do_end, 0..1)
      fgoto main;
    };

    (
      kw_class | kw_module | kw_def | kw_begin | kw_case | kw_if | kw_unless |
      kw_class . ospaces . '<<' . ospaces . ^newline+
    ) => {
      push(:kw_do_alias1, ts, te)
      increment_counter(:do_end, 1)
      fgoto main;
    };

    ospaces => { push(:space, ts, te) };
    any => { fhold; fgoto main; };

  *|;

  ## MACHINE >> One-liner comment
  per_line_comment := |*
    ^newline* => {
      push(:comment, ts.pred, te)
      fgoto main;
    };
  *|;

  ## MACHINE >> Block comment
  block_comment := |*
    any* . newline . '=end' . ospaces . ^newline* => {
      unless push_comment(ts, te)
        fgoto main;
      end
    };
  *|;

  ## MACHINE >> Heredoc
  heredoc := |*
    ^newline* . newline . ospaces . ^newline+ => {
      unless push_heredoc(ts, te)
        fgoto main;
      end
    };
  *|;

  ## MACHINE >> Double quote string
  double_quote_str := |*
    delimiter = [\~\`\!\@\#\$\%\^\&\*\)\-\_\+\=\}\]\:\;\'\"\>\,\.\?\/\|\\];
    (^delimiter* . delimiter) -- ('\\' . delimiter) => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;

  ## MACHINE >> Main
  main := |*

    ## == Start/end of do..end block

    kw_do => {
      push(:kw_do, ts, te)
      increment_counter(:do_end)
      fgoto new_statement;
    };

    kw_end => {
      push(:kw_end, ts, te)
      decrement_counter(:do_end)
    };

    ## == Start/end of {...} block

    lbrace => {
      push(:lbrace, ts, te)
      increment_counter(:brace)
    };

    rbrace => {
      push(:rbrace, ts, te)
      decrement_counter(:brace)
    };

    assoc => {
      push(:assoc, ts, te)
      fix_counter_false_start(:brace)
    };

    label => {
      push_label(ts, te)
      fix_counter_false_start(:brace)
    };

    ## == New statement

    newline => {
      push(:newline, ts, te)
      increment_lineno
      fgoto new_statement;
    };

    smcolon | lparen | assgn | kw_then | comma => {
      push(:newline_alias, ts, te)
      fgoto new_statement;
    };

    ## == Comment

    '#' => {
      fgoto per_line_comment;
    };

    newline . '=begin' . ospaces . (ospaces . ^newline+)* . newline => {
      push_comment(ts, te)
      increment_lineno
      fgoto block_comment;
    };

    ## == Misc

    var     => { push(:var, ts, te) };
    const   => { push(:const, ts, te) };
    symbol  => { push(:symbol, ts, te) };
    mspaces => { push(:space, ts, te) };
    any     => { push(:any, ts, te) };

    ## == Heredoc

    ('<<' | '<<-') . ["']? . (const | var) . ["']? . newline => {
      push_heredoc(ts, te)
      increment_lineno
      fgoto heredoc;
    };

    ## == Single quote strings

    sqs1  = "'" . ([^\']* | ([^\'\\]*[\\][\'][^\']*)*) . '\\\\'* . "'";
    sqs2  = '~' . ([^\~]* | ([^\~\\]*[\\][\~][^\~]*)*) . '\\\\'* . '~';
    sqs3  = '`' . ([^\`]* | ([^\`\\]*[\\][\`][^\`]*)*) . '\\\\'* . '`';
    sqs4  = '!' . ([^\!]* | ([^\!\\]*[\\][\!][^\!]*)*) . '\\\\'* . '!';
    sqs5  = '@' . ([^\@]* | ([^\@\\]*[\\][\@][^\@]*)*) . '\\\\'* . '@';
    sqs6  = '#' . ([^\#]* | ([^\#\\]*[\\][\#][^\#]*)*) . '\\\\'* . '#';
    sqs7  = '$' . ([^\$]* | ([^\$\\]*[\\][\$][^\$]*)*) . '\\\\'* . '$';
    sqs8  = '%' . ([^\%]* | ([^\%\\]*[\\][\%][^\%]*)*) . '\\\\'* . '%';
    sqs9  = '^' . ([^\^]* | ([^\^\\]*[\\][\^][^\^]*)*) . '\\\\'* . '^';
    sqs10 = '&' . ([^\&]* | ([^\&\\]*[\\][\&][^\&]*)*) . '\\\\'* . '&';
    sqs11 = '*' . ([^\*]* | ([^\*\\]*[\\][\*][^\*]*)*) . '\\\\'* . '*';
    sqs12 = '-' . ([^\-]* | ([^\-\\]*[\\][\-][^\-]*)*) . '\\\\'* . '-';
    sqs13 = '_' . ([^\_]* | ([^\_\\]*[\\][\_][^\_]*)*) . '\\\\'* . '_';
    sqs14 = '+' . ([^\+]* | ([^\+\\]*[\\][\+][^\+]*)*) . '\\\\'* . '+';
    sqs15 = '=' . ([^\=]* | ([^\=\\]*[\\][\=][^\=]*)*) . '\\\\'* . '=';
    sqs16 = '<' . ([^\>]* | ([^\>\\]*[\\][\>][^\>]*)*) . '\\\\'* . '>';
    sqs17 = '|' . ([^\|]* | ([^\|\\]*[\\][\|][^\|]*)*) . '\\\\'* . '|';
    sqs18 = ':' . ([^\:]* | ([^\:\\]*[\\][\:][^\:]*)*) . '\\\\'* . ':';
    sqs19 = ';' . ([^\;]* | ([^\;\\]*[\\][\;][^\;]*)*) . '\\\\'* . ';';
    sqs20 = '"' . ([^\"]* | ([^\"\\]*[\\][\"][^\"]*)*) . '\\\\'* . '"';
    sqs21 = ',' . ([^\,]* | ([^\,\\]*[\\][\,][^\,]*)*) . '\\\\'* . ',';
    sqs22 = '.' . ([^\.]* | ([^\.\\]*[\\][\.][^\.]*)*) . '\\\\'* . '.';
    sqs23 = '?' . ([^\?]* | ([^\?\\]*[\\][\?][^\?]*)*) . '\\\\'* . '?';
    sqs24 = '/' . ([^\/]* | ([^\/\\]*[\\][\/][^\/]*)*) . '\\\\'* . '/';
    sqs25 = '{' . ([^\}]* | ([^\}\\]*[\\][\}][^\}]*)*) . '\\\\'* . '}';
    sqs26 = '[' . ([^\]]* | ([^\]\\]*[\\][\]][^\]]*)*) . '\\\\'* . ']';
    sqs27 = '(' . ([^\)]* | ([^\)\\]*[\\][\)][^\)]*)*) . '\\\\'* . ')';
    sqs28 = '\\' . ([^\\]* | ([^\)]*[\\][\\][^\\]*)*) . '\\';

    sqm = ('%q' | '%w'); (
      sqs1        | sqm . sqs1  | sqm . sqs2  | sqm . sqs3  | sqm . sqs4  |
      sqm . sqs5  | sqm . sqs6  | sqm . sqs7  | sqm . sqs8  | sqm . sqs9  |
      sqm . sqs10 | sqm . sqs11 | sqm . sqs12 | sqm . sqs13 | sqm . sqs14 |
      sqm . sqs15 | sqm . sqs16 | sqm . sqs17 | sqm . sqs18 | sqm . sqs19 |
      sqm . sqs20 | sqm . sqs21 | sqm . sqs22 | sqm . sqs23 | sqm . sqs24 |
      sqm . sqs25 | sqm . sqs26 | sqm . sqs27 | sqm . sqs28
    ) => {
      push(:sstring, ts, te)
    };

    ## == Double quote strings

    dqs1  = '"' . (([^\"]* | ([^\"\\]*[\\][\"][^\"]*)*) -- '#{') . '\\\\'* . ('"' | '#{');
    dqs2  = '`' . (([^\`]* | ([^\`\\]*[\\][\`][^\`]*)*) -- '#{') . '\\\\'* . ('`' | '#{');
    dqs3  = '/' . (([^\/]* | ([^\/\\]*[\\][\/][^\/]*)*) -- '#{') . '\\\\'* . ('/' | '#{');
    dqs4  = "'" . (([^\']* | ([^\'\\]*[\\][\'][^\']*)*) -- '#{') . '\\\\'* . ("'" | '#{');
    dqs5  = '~' . (([^\~]* | ([^\~\\]*[\\][\~][^\~]*)*) -- '#{') . '\\\\'* . ('~' | '#{');
    dqs6  = '!' . (([^\!]* | ([^\!\\]*[\\][\!][^\!]*)*) -- '#{') . '\\\\'* . ('!' | '#{');
    dqs7  = '@' . (([^\@]* | ([^\@\\]*[\\][\@][^\@]*)*) -- '#{') . '\\\\'* . ('@' | '#{');
    dqs8  = '#' . (([^\#]* | ([^\#\\]*[\\][\#][^\#]*)*) -- '#{') . '\\\\'* . ('#' | '#{');
    dqs9  = '$' . (([^\$]* | ([^\$\\]*[\\][\$][^\$]*)*) -- '#{') . '\\\\'* . ('$' | '#{');
    dqs10 = '%' . (([^\%]* | ([^\%\\]*[\\][\%][^\%]*)*) -- '#{') . '\\\\'* . ('%' | '#{');
    dqs11 = '^' . (([^\^]* | ([^\^\\]*[\\][\^][^\^]*)*) -- '#{') . '\\\\'* . ('^' | '#{');
    dqs12 = '&' . (([^\&]* | ([^\&\\]*[\\][\&][^\&]*)*) -- '#{') . '\\\\'* . ('&' | '#{');
    dqs13 = '*' . (([^\*]* | ([^\*\\]*[\\][\*][^\*]*)*) -- '#{') . '\\\\'* . ('*' | '#{');
    dqs14 = '-' . (([^\-]* | ([^\-\\]*[\\][\-][^\-]*)*) -- '#{') . '\\\\'* . ('-' | '#{');
    dqs15 = '_' . (([^\_]* | ([^\_\\]*[\\][\_][^\_]*)*) -- '#{') . '\\\\'* . ('_' | '#{');
    dqs16 = '+' . (([^\+]* | ([^\+\\]*[\\][\+][^\+]*)*) -- '#{') . '\\\\'* . ('+' | '#{');
    dqs17 = '=' . (([^\=]* | ([^\=\\]*[\\][\=][^\=]*)*) -- '#{') . '\\\\'* . ('=' | '#{');
    dqs18 = '<' . (([^\>]* | ([^\>\\]*[\\][\>][^\>]*)*) -- '#{') . '\\\\'* . ('>' | '#{');
    dqs19 = '|' . (([^\|]* | ([^\|\\]*[\\][\|][^\|]*)*) -- '#{') . '\\\\'* . ('|' | '#{');
    dqs20 = ':' . (([^\:]* | ([^\:\\]*[\\][\:][^\:]*)*) -- '#{') . '\\\\'* . (':' | '#{');
    dqs21 = ';' . (([^\;]* | ([^\;\\]*[\\][\;][^\;]*)*) -- '#{') . '\\\\'* . (';' | '#{');
    dqs22 = ',' . (([^\,]* | ([^\,\\]*[\\][\,][^\,]*)*) -- '#{') . '\\\\'* . (',' | '#{');
    dqs23 = '.' . (([^\.]* | ([^\.\\]*[\\][\.][^\.]*)*) -- '#{') . '\\\\'* . ('.' | '#{');
    dqs24 = '?' . (([^\?]* | ([^\?\\]*[\\][\?][^\?]*)*) -- '#{') . '\\\\'* . ('?' | '#{');
    dqs25 = '{' . (([^\}]* | ([^\}\\]*[\\][\}][^\}]*)*) -- '#{') . '\\\\'* . ('}' | '#{');
    dqs26 = '[' . (([^\]]* | ([^\]\\]*[\\][\]][^\]]*)*) -- '#{') . '\\\\'* . (']' | '#{');
    dqs27 = '(' . (([^\)]* | ([^\)\\]*[\\][\)][^\)]*)*) -- '#{') . '\\\\'* . (')' | '#{');
    dqs28 = '\\' . (([^\\]* | ([^\\]*[\\][\\][^\\]*)*) -- '#{') . ('\\' | '#{');

    dqm = ('%Q' | '%W' | '%x' | '%r' | '%'); (
      dqs1        | dqs2        | dqs3        | dqm . dqs1  | dqm . dqs2  |
      dqm . dqs3  | dqm . dqs4  | dqm . dqs5  | dqm . dqs6  | dqm . dqs7  |
      dqm . dqs8  | dqm . dqs9  | dqm . dqs10 | dqm . dqs11 | dqm . dqs12 |
      dqm . dqs13 | dqm . dqs14 | dqm . dqs15 | dqm . dqs16 | dqm . dqs17 |
      dqm . dqs18 | dqm . dqs19 | dqm . dqs20 | dqm . dqs21 | dqm . dqs22 |
      dqm . dqs23 | dqm . dqs24 | dqm . dqs25 | dqm . dqs26 | dqm . dqs27 |
      dqm . dqs28
    ) => {
      if push_dstring(ts, te)
        fgoto double_quote_str;
      end
    };

  *|;

}%%
%% write data;

      extend Scanner::Extensions

      def self.execute!
        data = @data
        eof = data.length
        %% write init;
        %% write exec;
      end

    end
  end
end
