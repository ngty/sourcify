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

  vchar   = alnum | '_';
  const   = upper . vchar* . ('::' . alpha . vchar*)*;
  var     = (lower | '_') . vchar*;
  meth    = (alpha | '_') . vchar*;
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
  bslash  = '\\' . newline;
  ospaces = space* -- newline;
  mspaces = space+ -- newline;

  ## MACHINE >> New statement
  new_statement := |*

    (kw_for | kw_while | kw_until) . ^vchar => {
      push(:kw_do_alias2, ts, te)
      increment_counter(:do_end, 0..1)
      fgoto main;
    };

    (
      ((kw_class | kw_module | kw_def | kw_begin | kw_case | kw_if | kw_unless) . ^vchar) |
      (kw_class . ospaces . '<<' . ospaces . ^newline+)
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

  ## MACHINE >> String
  string := |*

    sqm = '%q' | '%w';
    dqm = '%Q' | '%W' | '%x' | '%r' | '%';

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

    ( sqs1        | sqm . sqs1  | sqm . sqs2  | sqm . sqs3  | sqm . sqs4  |
      sqm . sqs5  | sqm . sqs6  | sqm . sqs7  | sqm . sqs8  | sqm . sqs9  |
      sqm . sqs10 | sqm . sqs11 | sqm . sqs12 | sqm . sqs13 | sqm . sqs14 |
      sqm . sqs15 | sqm . sqs16 | sqm . sqs17 | sqm . sqs18 | sqm . sqs19 |
      sqm . sqs20 | sqm . sqs21 | sqm . sqs22 | sqm . sqs23 | sqm . sqs24 |
      sqm . sqs25 | sqm . sqs26 | sqm . sqs27 | sqm . sqs28
    ) => {
      push(:sstring, ts, te);
      fgoto main;
    };

    ## == Double quote strings
    (dqm . '"') | '"' => { push_dstring(ts, te); fgoto dstring1; };
    (dqm . "'") | "'" => { push_dstring(ts, te); fgoto dstring2; };
    (dqm . '/') | '/' => { push_dstring(ts, te); fgoto dstring3; };
    (dqm . '`') | '`' => { push_dstring(ts, te); fgoto dstring4; };
    dqm . '~'  => { push_dstring(ts, te); fgoto dstring5; };
    dqm . '!'  => { push_dstring(ts, te); fgoto dstring6; };
    dqm . '@'  => { push_dstring(ts, te); fgoto dstring7; };
    dqm . '#'  => { push_dstring(ts, te); fgoto dstring8; };
    dqm . '$'  => { push_dstring(ts, te); fgoto dstring9; };
    dqm . '%'  => { push_dstring(ts, te); fgoto dstring10; };
    dqm . '^'  => { push_dstring(ts, te); fgoto dstring11; };
    dqm . '&'  => { push_dstring(ts, te); fgoto dstring12; };
    dqm . '*'  => { push_dstring(ts, te); fgoto dstring13; };
    dqm . '-'  => { push_dstring(ts, te); fgoto dstring14; };
    dqm . '_'  => { push_dstring(ts, te); fgoto dstring15; };
    dqm . '+'  => { push_dstring(ts, te); fgoto dstring16; };
    dqm . '='  => { push_dstring(ts, te); fgoto dstring17; };
    dqm . '<'  => { push_dstring(ts, te); fgoto dstring18; };
    dqm . '|'  => { push_dstring(ts, te); fgoto dstring19; };
    dqm . ':'  => { push_dstring(ts, te); fgoto dstring20; };
    dqm . ';'  => { push_dstring(ts, te); fgoto dstring21; };
    dqm . ','  => { push_dstring(ts, te); fgoto dstring22; };
    dqm . '.'  => { push_dstring(ts, te); fgoto dstring23; };
    dqm . '?'  => { push_dstring(ts, te); fgoto dstring24; };
    dqm . '{'  => { push_dstring(ts, te); fgoto dstring25; };
    dqm . '['  => { push_dstring(ts, te); fgoto dstring26; };
    dqm . '('  => { push_dstring(ts, te); fgoto dstring27; };
    dqm . '\\' => { push_dstring(ts, te); fgoto dstring28; };

    ## == Anything accidentally caught
    any => {
      push(:any, ts, te)
      fgoto main;
    };
  *|;

  ## MACHINES >> Double quote strings
  dstring1 := |*
    [^\"]*[\"] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring2 := |*
    [^\']*[\'] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring3 := |*
    [^\/]*[\/] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring4 := |*
    [^\`]*[\`] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring5 := |*
    [^\~]*[\~] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring6 := |*
    [^\!]*[\!] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring7 := |*
    [^\@]*[\@] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring8 := |*
    [^\#]*[\#] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring9 := |*
    [^\$]*[\$] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring10 := |*
    [^\%]*[\%] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring11 := |*
    [^\^]*[\^] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring12 := |*
    [^\&]*[\&] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring13 := |*
    [^\*]*[\*] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring14 := |*
    [^\-]*[\-] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring15 := |*
    [^\_]*[\_] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring16 := |*
    [^\+]*[\+] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring17 := |*
    [^\=]*[\=] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring18 := |*
    [^\>]*[\>] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring19 := |*
    [^\|]*[\|] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring20 := |*
    [^\:]*[\:] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring21 := |*
    [^\;]*[\;] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring22 := |*
    [^\,]*[\,] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring23 := |*
    [^\.]*[\.] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring24 := |*
    [^\?]*[\?] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring25 := |*
    [^\}]*[\}] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring26 := |*
    [^\]]*[\]] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring27 := |*
    [^\)]*[\)] => {
      unless push_dstring(ts, te)
        fgoto main;
      end
    };
  *|;
  dstring28 := |*
    [^\\]*[\\] => {
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

    ## == Strings

    ('<<' | '<<-') . ["']? . (const | var) . ["']? . newline => {
      push_heredoc(ts, te)
      increment_lineno
      fgoto heredoc;
    };

    ('"' | "'" | '`' | '%') => {
      fhold; fgoto string;
    };

    '/' => {
      if preceded_with?(:char, :digit, :var, :const, :symbol, :dstring, :sstring, ')', ']', '}')
        push(:op, ts, te)
      else
        fhold; fgoto string;
      end
    };

    ## == Misc

    var         => { push(:var, ts, te) };
    bslash      => { push(:bslash, ts, te) };
    const       => { push(:const, ts, te) };
    symbol      => { push(:symbol, ts, te) };
    mspaces     => { push(:space, ts, te) };
    [0-9]       => { push(:digit, ts, te) };
    lower       => { push(:char, ts, te) };
    any         => { push(:any, ts, te) };

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
