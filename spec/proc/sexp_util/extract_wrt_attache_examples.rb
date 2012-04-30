# -*- encoding: utf-8 -*-

f(%%
## w declared recipient & method
##
#> [:method_add_block,
#>  [:call,
#>   [:var_ref, [:@const, "Proc", [18, 2]]],
#>   :".",
#>   [:@ident, "new", [18, 7]]],
#>  [:do_block,
#>   nil,
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [19, 5]]]]]]]
##
%,(
  Proc.new do
    :nil
  end
))

f(%%
## w implied self method
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "proc", [35, 2]]], [:args_new]],
#>  [:do_block,
#>   nil,
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [36, 5]]]]]]]
##
%,(
  proc do
    :nil
  end
))

# __END__
