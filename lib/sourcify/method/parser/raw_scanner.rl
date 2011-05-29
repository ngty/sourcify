Sourcify.require_rb('method', 'parser', 'raw_scanner_extensions')

module Sourcify
  module Method
    class Parser
      module RawScanner #:nodoc:all

%%{

  machine scanner;
  include common 'common.rl';

  ## MACHINE >> New statement
  new_statement := |*

    (kw_for | kw_while | kw_until) . ^vchar => {
      push(:kw_do_alias2, ts, te)
      increment_counter(0..1)
      fgoto main;
    };

    (
      ((kw_class | kw_module | kw_do | kw_begin | kw_case | kw_if | kw_unless) . ^vchar) |
      (kw_class . ospaces . '<<' . ospaces . ^newline+)
    ) => {
      push(:kw_do_alias1, ts, te)
      increment_counter(1)
      fgoto main;
    };

    ospaces => { push(:space, ts, te) };
    any => { fhold; fgoto main; };

  *|;


  ## MACHINE >> Main
  main := |*

    ## == Start/end of def..end block

    kw_def => {
      push(:kw_def, ts, te)
      increment_counter(1)
      fgoto new_statement;
    };

    kw_end => {
      push(:kw_end, ts, te)
      decrement_counter()
    };

    ## == Start/end of {...} block

    lbrace => {
      push(:lbrace, ts, te)
    };

    rbrace => {
      push(:rbrace, ts, te)
    };

    assoc => {
      push(:assoc, ts, te)
    };

    label => {
      push_label(ts, te)
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

        extend Extensions

        def self.execute!
          data = @data
          eof = data.length
          %% write init;
          %% write exec;
        end

      end
    end
  end
end
