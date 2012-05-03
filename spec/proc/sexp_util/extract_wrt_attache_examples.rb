# -*- encoding: utf-8 -*-

f(%%
## w declared recipient & method
##
#> [:method_add_block,
#>  [:call,
#>   [:var_ref, [:@const, "Proc", [18, 6]]],
#>   :".",
#>   [:@ident, "new", [18, 11]]],
#>  [:do_block,
#>   nil,
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [19, 5]]]]]]]
##
%,(
  b = Proc.new do
    :nil
  end
))

f(%%
## w implied self method
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "proc", [35, 6]]], [:args_new]],
#>  [:do_block,
#>   nil,
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [36, 5]]]]]]]
##
%,(
  b = proc do
    :nil
  end
))

# __END__
