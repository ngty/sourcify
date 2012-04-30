# -*- encoding: utf-8 -*-
thingy = Proc

f(%%
## w instance method, do-block & having no arg
##
#> [:method_add_block,
#>  [:call,
#>   [:var_ref, [:@ident, "thingy", [19, 2]]],
#>   :".",
#>   [:@ident, "new", [19, 9]]],
#>  [:do_block,
#>   nil,
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [20, 5]]]]]]]
##
%,(
  thingy.new do
    :nil
  end
))

f(%%
## w instance method, do-block & having 1 arg
##
#> [:method_add_block,
#>  [:call,
#>   [:var_ref, [:@ident, "thingy", [41, 2]]],
#>   :".",
#>   [:@ident, "new", [41, 9]]],
#>  [:do_block,
#>   [:block_var,
#>    [:params, [[:@ident, "x", [41, 17]]], nil, nil, nil, nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [42, 5]]]]]]]
##
%,(
  thingy.new do |x|
    :nil
  end
))

f(%%
## w instance method, do-block & having multiple args
##
#> [:method_add_block,
#>  [:call,
#>   [:var_ref, [:@ident, "thingy", [70, 2]]],
#>   :".",
#>   [:@ident, "new", [70, 9]]],
#>  [:do_block,
#>   [:block_var,
#>    [:params,
#>     [[:@ident, "x", [70, 17]],
#>      [:@ident, "y", [70, 20]],
#>      [:@ident, "z", [70, 23]]],
#>     nil,
#>     nil,
#>     nil,
#>     nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [71, 5]]]]]]]
##
%,(
  thingy.new do |x, y, z|
    :nil
  end
))

f(%%
## w instance method, brace-block & having no arg
##
#> [:method_add_block,
#>  [:call,
#>   [:var_ref, [:@ident, "thingy", [90, 2]]],
#>   :".",
#>   [:@ident, "new", [90, 9]]],
#>  [:brace_block,
#>   nil,
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [91, 5]]]]]]]
##
%,(
  thingy.new {
    :nil
  }
))

f(%%
## w instance method, brace-block & having 1 arg
##
#> [:method_add_block,
#>  [:call,
#>   [:var_ref, [:@ident, "thingy", [112, 2]]],
#>   :".",
#>   [:@ident, "new", [112, 9]]],
#>  [:brace_block,
#>   [:block_var,
#>    [:params, [[:@ident, "x", [112, 15]]], nil, nil, nil, nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [113, 5]]]]]]]
##
%,(
  thingy.new {|x|
    :nil
  }
))

f(%%
## w instance method, brace-block & having multiple args
##
#> [:method_add_block,
#>  [:call,
#>   [:var_ref, [:@ident, "thingy", [141, 2]]],
#>   :".",
#>   [:@ident, "new", [141, 9]]],
#>  [:brace_block,
#>   [:block_var,
#>    [:params,
#>     [[:@ident, "x", [141, 15]],
#>      [:@ident, "y", [141, 18]],
#>      [:@ident, "z", [141, 21]]],
#>     nil,
#>     nil,
#>     nil,
#>     nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [142, 5]]]]]]]
##
%,(
  thingy.new {|x, y, z|
    :nil
  }
))
