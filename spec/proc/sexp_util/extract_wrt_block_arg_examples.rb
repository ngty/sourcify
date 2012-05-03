# -*- encoding: utf-8 -*-

f(%%
## w no arg
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "proc", [15, 6]]], [:args_new]],
#>  [:do_block,
#>   nil,
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [16, 5]]]]]]]
##
%,(
  b = proc do
    :nil
  end
))

f(%%
## w 1 arg
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "proc", [34, 6]]], [:args_new]],
#>  [:do_block,
#>   [:block_var,
#>    [:params, [[:@ident, "x", [34, 15]]], nil, nil, nil, nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [35, 5]]]]]]]
##
%,(
  b = proc do |x|
    :nil
  end
))

f(%%
## w multiple args
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "proc", [60, 2]]], [:args_new]],
#>  [:do_block,
#>   [:block_var,
#>    [:params,
#>     [[:@ident, "x", [60, 11]],
#>      [:@ident, "y", [60, 14]],
#>      [:@ident, "z", [60, 17]]],
#>     nil,
#>     nil,
#>     nil,
#>     nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [61, 5]]]]]]]
##
%,(
  proc do |x, y, z|
    :nil
  end
))

# __END__
