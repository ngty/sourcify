require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::Extractor do
  describe '.process (wrt sexp)' do
    extend Sourcify::SpecHelper

    def process(block)
      Sourcify::Proc::Extractor.process(block).sexp
    end

    example(%%
    ## wrt attache, having declared recipient for method
    ##
    #> [:method_add_block,
    #>  [:call,
    #>   [:var_ref, [:@const, "Proc", [#{__LINE__+9}, 10]]],
    #>   :".",
    #>   [:@ident, "new", [#{__LINE__+7}, 15]]],
    #>  [:do_block,
    #>   nil,
    #>   [:stmts_add,
    #>    [:stmts_new],
    #>    [:symbol_literal, [:symbol, [:@ident, "thing", [#{__LINE__+3}, 9]]]]]]]
    %,(
      b = Proc.new do
        :thing
      end
    ))

    example(%%
    ## wrt attache, having implicit recipient for method
    ##
    #> [:method_add_block,
    #>  [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+7}, 10]]], [:args_new]],
    #>  [:do_block,
    #>   nil,
    #>   [:stmts_add,
    #>    [:stmts_new],
    #>    [:symbol_literal, [:symbol, [:@ident, "thing", [#{__LINE__+3}, 9]]]]]]]
    %,(
      b = proc do
        :thing
      end
    ))

    example(%%
    ## wrt attache, having explicit recipient for method
    ##
    #> [:method_add_block,
    #>  [:call,
    #>   [:var_ref, [:@ident, "subject", [#{__LINE__+10}, 10]]],
    #>   :".",
    #>   [:@ident, "new", [#{__LINE__+8}, 18]]],
    #>  [:do_block,
    #>   nil,
    #>   [:stmts_add,
    #>    [:stmts_new],
    #>    [:symbol_literal, [:symbol, [:@ident, "thing", [#{__LINE__+4}, 9]]]]]]]
    %,(
      subject = Proc
      b = subject.new do
        :thing
      end
    ))

    example(%%
    ## wrt block args, having no arg
    ##
    #> [:method_add_block,
    #>  [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+7}, 10]]], [:args_new]],
    #>  [:do_block,
    #>   nil,
    #>   [:stmts_add,
    #>    [:stmts_new],
    #>    [:symbol_literal, [:symbol, [:@ident, "thing", [#{__LINE__+3}, 9]]]]]]]
    %,(
      b = proc do
        :thing
      end
    ))

    example(%%
    ## wrt block args, having 1 arg
    ##
    #> [:method_add_block,
    #>  [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+9}, 10]]], [:args_new]],
    #>  [:do_block,
    #>   [:block_var,
    #>    [:params, [[:@ident, "x", [#{__LINE__+6}, 19]]], nil, nil, nil, nil],
    #>    nil],
    #>   [:stmts_add,
    #>    [:stmts_new],
    #>    [:symbol_literal, [:symbol, [:@ident, "thing", [#{__LINE__+3}, 9]]]]]]]
    %,(
      b = proc do |x|
        :thing
      end
    ))

    example(%%
    ## wrt block args, having multiple args
    ##
    #> [:method_add_block,
    #>  [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+16}, 10]]], [:args_new]],
    #>  [:do_block,
    #>   [:block_var,
    #>    [:params,
    #>     [[:@ident, "x", [#{__LINE__+12}, 19]],
    #>      [:@ident, "y", [#{__LINE__+11}, 22]],
    #>      [:@ident, "z", [#{__LINE__+10}, 25]]],
    #>     nil,
    #>     nil,
    #>     nil,
    #>     nil],
    #>    nil],
    #>   [:stmts_add,
    #>    [:stmts_new],
    #>    [:symbol_literal, [:symbol, [:@ident, "thing", [#{__LINE__+3}, 9]]]]]]]
    %,(
      b = proc do |x, y, z|
        :thing
      end
    ))

    example(%%
    ## wrt block args, having only splat args
    ##
    #> [:method_add_block,
    #>  [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+9}, 10]]], [:args_new]],
    #>  [:do_block,
    #>   [:block_var,
    #>    [:params, nil, nil, [:rest_param, [:@ident, "x", [#{__LINE__+6}, 20]]], nil, nil],
    #>    nil],
    #>   [:stmts_add,
    #>    [:stmts_new],
    #>    [:symbol_literal, [:symbol, [:@ident, "thing", [#{__LINE__+3}, 9]]]]]]]
    %,(
      b = proc do |*x|
        :thing
      end
    ))

    example(%%
    ## wrt block args, having multiple & splat args
    ##
    #> [:method_add_block,
    #>  [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+14}, 10]]], [:args_new]],
    #>  [:do_block,
    #>   [:block_var,
    #>    [:params,
    #>     [[:@ident, "x", [#{__LINE__+10}, 19]], [:@ident, "y", [#{__LINE__+10}, 22]]],
    #>     nil,
    #>     [:rest_param, [:@ident, "z", [#{__LINE__+8}, 26]]],
    #>     nil,
    #>     nil],
    #>    nil],
    #>   [:stmts_add,
    #>    [:stmts_new],
    #>    [:symbol_literal, [:symbol, [:@ident, "thing", [#{__LINE__+3}, 9]]]]]]]
    %,(
      b = proc do |x, y, *z|
        :thing
      end
    ))

    example(%%
    ## wrt block type, as do-block
    ##
    #> [:method_add_block,
    #>  [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+7}, 10]]], [:args_new]],
    #>  [:do_block,
    #>   nil,
    #>   [:stmts_add,
    #>    [:stmts_new],
    #>    [:symbol_literal, [:symbol, [:@ident, "thing", [#{__LINE__+3}, 9]]]]]]]
    %,(
      b = proc do
        :thing
      end
    ))

    example(%%
    ## wrt block type, as brace-block
    ##
    #> [:method_add_block,
    #>  [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+7}, 10]]], [:args_new]],
    #>  [:brace_block,
    #>   nil,
    #>   [:stmts_add,
    #>    [:stmts_new],
    #>    [:symbol_literal, [:symbol, [:@ident, "thing", [#{__LINE__+3}, 9]]]]]]]
    %,(
      b = proc {
        :thing
      }
    ))

    example(%%
    ## wrt multiple matches, having unique parameters
    ##
    #> [:method_add_block,
    #>  [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+19}, 10]]], [:args_new]],
    #>  [:do_block,
    #>   [:block_var,
    #>    [:params, [[:@ident, "x", [#{__LINE__+16}, 19]]], nil, nil, nil, nil],
    #>    nil],
    #>   [:stmts_add,
    #>    [:stmts_add,
    #>     [:stmts_new],
    #>     [:method_add_block,
    #>      [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+10}, 22]]], [:args_new]],
    #>      [:brace_block,
    #>       [:block_var,
    #>        [:params, [[:@ident, "y", [#{__LINE__+7}, 29]]], nil, nil, nil, nil],
    #>        nil],
    #>       [:stmts_add,
    #>        [:stmts_new],
    #>        [:symbol_literal, [:symbol, [:@ident, "this", [#{__LINE__+3}, 33]]]]]]]],
    #>    [:symbol_literal, [:symbol, [:@ident, "that", [#{__LINE__+3}, 9]]]]]]]
    %,(
      b = proc do |x| proc {|y| :this }
        :that
      end
    ))

    example(%%
    ## wrt multiple matches, having non-unique parameters
    ##
    #! Sourcify::MultipleMatchingProcsPerLineError
    %,(
      b = proc do |x| proc {|x| :this }
        :that
      end
    ))

  end
end
