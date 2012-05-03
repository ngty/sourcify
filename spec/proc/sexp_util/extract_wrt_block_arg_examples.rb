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
#>  [:method_add_arg, [:fcall, [:@ident, "proc", [60, 6]]], [:args_new]],
#>  [:do_block,
#>   [:block_var,
#>    [:params,
#>     [[:@ident, "x", [60, 15]],
#>      [:@ident, "y", [60, 18]],
#>      [:@ident, "z", [60, 21]]],
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
  b = proc do |x, y, z|
    :nil
  end
))

f(%%
## w only splat args
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "proc", [79, 6]]], [:args_new]],
#>  [:do_block,
#>   [:block_var,
#>    [:params, nil, nil, [:rest_param, [:@ident, "x", [79, 16]]], nil, nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [80, 5]]]]]]]
##
%,(
  b = proc do |*x|
    :nil
  end
))

f(%%
## w multiple & splat args
#>
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "proc", [103, 6]]], [:args_new]],
#>  [:do_block,
#>   [:block_var,
#>    [:params,
#>     [[:@ident, "x", [103, 15]], [:@ident, "y", [103, 18]]],
#>     nil,
#>     [:rest_param, [:@ident, "z", [103, 22]]],
#>     nil,
#>     nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [104, 5]]]]]]]
##
%,(
  b = proc do |x, y, *z|
    :nil
  end
))

# __END__
