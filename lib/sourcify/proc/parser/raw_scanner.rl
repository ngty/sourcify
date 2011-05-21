Sourcify.require_rb('proc', 'parser', 'raw_scanner_extensions')

module Sourcify
  module Proc
    class Parser
      module RawScanner #:nodoc:all

%%{

  machine scanner;
  include common 'common.rl';

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
