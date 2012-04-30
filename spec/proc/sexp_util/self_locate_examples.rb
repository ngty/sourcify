# -*- encoding: utf-8 -*-
def thingy(&block)
  block
end

f(%%
## w self method, do-block & having no arg
##
#> {:from => [12,2], :till => [14,5]}
##
%,(
  thingy do
    :nil
  end
))

f(%%
## w self method, do-block & having 1 arg
##
#> {:from => [23,2], :till => [25,5]}
##
%,(
  thingy do |x|
    :nil
  end
))

f(%%
## w self method, do-block & having multiple args
##
#> {:from => [34,2], :till => [36,5]}
##
%,(
  thingy do |x, y, z|
    :nil
  end
))

f(%%
## w self method, brace-block & having no arg
##
#> {:from => [45,2], :till => [47,3]}
##
%,(
  thingy {
    :nil
  }
))

f(%%
## w self method, brace-block & having 1 arg
##
#> {:from => [56,2], :till => [58,3]}
##
%,(
  thingy {|x|
    :nil
  }
))

f(%%
## w self method, brace-block & having multiple args
##
#> {:from => [67,2], :till => [69,3]}
##
%,(
  thingy {|x, y, z|
    :nil
  }
))
