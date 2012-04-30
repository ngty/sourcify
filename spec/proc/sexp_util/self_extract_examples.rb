# -*- encoding: utf-8 -*-
def thingy(&block)
  block
end

f(%%
## w self method, do-block & having no arg
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "thingy", [18, 2]]], [:args_new]],
#>  [:do_block,
#>   nil,
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [19, 5]]]]]]]
##
%,(
  thingy do
    :nil
  end
))

f(%%
## w self method, do-block & having 1 arg
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "thingy", [37, 2]]], [:args_new]],
#>  [:do_block,
#>   [:block_var,
#>    [:params, [[:@ident, "x", [37, 13]]], nil, nil, nil, nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [38, 5]]]]]]]
##
%,(
  thingy do |x|
    :nil
  end
))

f(%%
## w self method, do-block & having multiple args
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "thingy", [63, 2]]], [:args_new]],
#>  [:do_block,
#>   [:block_var,
#>    [:params,
#>     [[:@ident, "x", [63, 13]],
#>      [:@ident, "y", [63, 16]],
#>      [:@ident, "z", [63, 19]]],
#>     nil,
#>     nil,
#>     nil,
#>     nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [64, 5]]]]]]]
##
%,(
  thingy do |x, y, z|
    :nil
  end
))

f(%%
## w self method, brace-block & having no arg
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "thingy", [80, 2]]], [:args_new]],
#>  [:brace_block,
#>   nil,
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [81, 5]]]]]]]
##
%,(
  thingy {
    :nil
  }
))

f(%%
## w self method, brace-block & having 1 arg
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "thingy", [99, 2]]], [:args_new]],
#>  [:brace_block,
#>   [:block_var,
#>    [:params, [[:@ident, "x", [99, 11]]], nil, nil, nil, nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [100, 5]]]]]]]
##
%,(
  thingy {|x|
    :nil
  }
))

f(%%
## w self method, brace-block & having multiple args
##
#> [:method_add_block,
#>  [:method_add_arg, [:fcall, [:@ident, "thingy", [125, 2]]], [:args_new]],
#>  [:brace_block,
#>   [:block_var,
#>    [:params,
#>     [[:@ident, "x", [125, 11]],
#>      [:@ident, "y", [125, 14]],
#>      [:@ident, "z", [125, 17]]],
#>     nil,
#>     nil,
#>     nil,
#>     nil],
#>    nil],
#>   [:stmts_add,
#>    [:stmts_new],
#>    [:symbol_literal, [:symbol, [:@kw, "nil", [126, 5]]]]]]]
##
%,(
  thingy {|x, y, z|
    :nil
  }
))
