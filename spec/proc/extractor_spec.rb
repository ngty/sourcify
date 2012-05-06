require File.expand_path('../spec_helper', __FILE__)

describe Sourcify::Proc::Extractor do
  describe '.process' do
    extend Sourcify::SpecHelper

    def process(block)
      file, line = block.source_location
      Sourcify::Proc::Extractor.process(file, :line => line)
    end

    example(%%
    ## wrt attache, having declared recipient for method
    ##
    #> {
    #>  :sexp =>
    #>   [:method_add_block,
    #>    [:call,
    #>     [:var_ref, [:@const, "Proc", [#{__LINE__+12}, 10]]],
    #>     :".",
    #>     [:@ident, "new", [#{__LINE__+10}, 15]]],
    #>    [:do_block,
    #>     nil,
    #>     [:stmts_add,
    #>      [:stmts_new],
    #>      [:symbol_literal, [:symbol, [:@kw, "nil", [#{__LINE__+6}, 9]]]]]]],
    #>  :positions =>
    #>   {:from => [#{__LINE__+3}, 10], :till => [#{__LINE__+5}, 9]}
    #> }
    %,(
      b = Proc.new do
        :nil
      end
    ))

    example(%%
    ## wrt attache, having implied recipient for method
    ##
    #> {
    #>  :sexp =>
    #>   [:method_add_block,
    #>    [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+10}, 10]]], [:args_new]],
    #>    [:do_block,
    #>     nil,
    #>     [:stmts_add,
    #>      [:stmts_new],
    #>      [:symbol_literal, [:symbol, [:@kw, "nil", [#{__LINE__+6}, 9]]]]]]],
    #>  :positions =>
    #>   {:from => [#{__LINE__+3}, 10], :till => [#{__LINE__+5}, 9]}
    #> }
    %,(
      b = proc do
        :nil
      end
    ))


    example(%%
    ## wrt block args, having no arg
    ##
    #> {
    #>  :sexp =>
    #>   [:method_add_block,
    #>    [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+10}, 10]]], [:args_new]],
    #>    [:do_block,
    #>     nil,
    #>     [:stmts_add,
    #>      [:stmts_new],
    #>      [:symbol_literal, [:symbol, [:@kw, "nil", [#{__LINE__+6}, 9]]]]]]],
    #>  :positions =>
    #>   {:from => [#{__LINE__+3}, 10], :till => [#{__LINE__+5}, 9]}
    #> }
    %,(
      b = proc do
        :nil
      end
    ))

    example(%%
    ## wrt block args, having 1 arg
    ##
    #> {
    #>  :sexp =>
    #>   [:method_add_block,
    #>    [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+12}, 10]]], [:args_new]],
    #>    [:do_block,
    #>     [:block_var,
    #>      [:params, [[:@ident, "x", [#{__LINE__+9}, 19]]], nil, nil, nil, nil],
    #>      nil],
    #>     [:stmts_add,
    #>      [:stmts_new],
    #>      [:symbol_literal, [:symbol, [:@kw, "nil", [#{__LINE__+6}, 9]]]]]]],
    #>  :positions =>
    #>   {:from => [#{__LINE__+3}, 10], :till => [#{__LINE__+5}, 9]}
    #> }
    %,(
      b = proc do |x|
        :nil
      end
    ))

    example(%%
    ## wrt block args, having multiple args
    ##
    #> {
    #>  :sexp =>
    #>   [:method_add_block,
    #>    [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+19}, 10]]], [:args_new]],
    #>    [:do_block,
    #>     [:block_var,
    #>      [:params,
    #>       [[:@ident, "x", [#{__LINE__+15}, 19]],
    #>        [:@ident, "y", [#{__LINE__+14}, 22]],
    #>        [:@ident, "z", [#{__LINE__+13}, 25]]],
    #>       nil,
    #>       nil,
    #>       nil,
    #>       nil],
    #>      nil],
    #>     [:stmts_add,
    #>      [:stmts_new],
    #>      [:symbol_literal, [:symbol, [:@kw, "nil", [#{__LINE__+6}, 9]]]]]]],
    #>  :positions =>
    #>   {:from => [#{__LINE__+3}, 10], :till => [#{__LINE__+5}, 9]}
    #> }
    %,(
      b = proc do |x, y, z|
        :nil
      end
    ))

    example(%%
    ## wrt block args, having only splat args
    ##
    #> {
    #>  :sexp =>
    #>   [:method_add_block,
    #>    [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+12}, 10]]], [:args_new]],
    #>    [:do_block,
    #>     [:block_var,
    #>      [:params, nil, nil, [:rest_param, [:@ident, "x", [#{__LINE__+9}, 20]]], nil, nil],
    #>      nil],
    #>     [:stmts_add,
    #>      [:stmts_new],
    #>      [:symbol_literal, [:symbol, [:@kw, "nil", [#{__LINE__+6}, 9]]]]]]],
    #>  :positions =>
    #>   {:from => [#{__LINE__+3}, 10], :till => [#{__LINE__+5}, 9]}
    #> }
    %,(
      b = proc do |*x|
        :nil
      end
    ))

    example(%%
    ## wrt block args, having multiple & splat args
    #>
    #> {
    #>  :sexp =>
    #>   [:method_add_block,
    #>    [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+17}, 10]]], [:args_new]],
    #>    [:do_block,
    #>     [:block_var,
    #>      [:params,
    #>       [[:@ident, "x", [#{__LINE__+13}, 19]], [:@ident, "y", [#{__LINE__+13}, 22]]],
    #>       nil,
    #>       [:rest_param, [:@ident, "z", [#{__LINE__+11}, 26]]],
    #>       nil,
    #>       nil],
    #>      nil],
    #>     [:stmts_add,
    #>      [:stmts_new],
    #>      [:symbol_literal, [:symbol, [:@kw, "nil", [#{__LINE__+6}, 9]]]]]]],
    #>  :positions =>
    #>   {:from => [#{__LINE__+3}, 10], :till => [#{__LINE__+5}, 9]}
    #> }
    %,(
      b = proc do |x, y, *z|
        :nil
      end
    ))

    example(%%
    ## wrt block type, as do-block
    ##
    #> {
    #>  :sexp =>
    #>   [:method_add_block,
    #>    [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+10}, 10]]], [:args_new]],
    #>    [:do_block,
    #>     nil,
    #>     [:stmts_add,
    #>      [:stmts_new],
    #>      [:symbol_literal, [:symbol, [:@kw, "nil", [#{__LINE__+6}, 9]]]]]]],
    #>  :positions =>
    #>   {:from => [#{__LINE__+3}, 10], :till => [#{__LINE__+5}, 9]}
    #> }
    %,(
      b = proc do
        :nil
      end
    ))

    example(%%
    ## wrt block type, as brace-block
    ##
    #> {
    #>  :sexp =>
    #>   [:method_add_block,
    #>    [:method_add_arg, [:fcall, [:@ident, "proc", [#{__LINE__+10}, 10]]], [:args_new]],
    #>    [:brace_block,
    #>     nil,
    #>     [:stmts_add,
    #>      [:stmts_new],
    #>      [:symbol_literal, [:symbol, [:@kw, "nil", [#{__LINE__+6}, 9]]]]]]],
    #>  :positions =>
    #>   {:from => [#{__LINE__+3}, 10], :till => [#{__LINE__+5}, 7]}
    #> }
    %,(
      b = proc {
        :nil
      }
    ))

  end
end
