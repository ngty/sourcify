# -*- encoding: utf-8 -*-
Thingy = Proc

f(%%
## w class method, do-block & having no arg
##
#> {:from => [10,2], :till => [12,5]}
##
%,(
  Thingy.new do
    :nil
  end
))

f(%%
## w class method, do-block & having 1 arg
##
#> {:from => [21,2], :till => [23,5]}
##
%,(
  Thingy.new do |x|
    :nil
  end
))

f(%%
## w class method, do-block & having multiple args
##
#> {:from => [32,2], :till => [34,5]}
##
%,(
  Thingy.new do |x, y, z|
    :nil
  end
))

f(%%
## w class method, brace-block & having no arg
##
#> {:from => [43,2], :till => [45,3]}
##
%,(
  Thingy.new {
    :nil
  }
))

f(%%
## w class method, brace-block & having 1 arg
##
#> {:from => [54,2], :till => [56,3]}
##
%,(
  Thingy.new {|x|
    :nil
  }
))

f(%%
## w class method, brace-block & having multiple args
##
#> {:from => [65,2], :till => [67,3]}
##
%,(
  Thingy.new {|x, y, z|
    :nil
  }
))
