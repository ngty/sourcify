# -*- encoding: utf-8 -*-
thing = Proc

f(%%
## w instance method, do-block & having no arg
##
#> {:from => [10,2], :till => [12,5]}
##
%,(
  thing.new do
    :nil
  end
))

f(%%
## w instance method, do-block & having 1 arg
##
#> {:from => [21,2], :till => [23,5]}
##
%,(
  thing.new do |x|
    :nil
  end
))

f(%%
## w instance method, do-block & having multiple args
##
#> {:from => [32,2], :till => [34,5]}
##
%,(
  thing.new do |x, y, z|
    :nil
  end
))

f(%%
## w instance method, brace-block & having no arg
##
#> {:from => [43,2], :till => [45,3]}
##
%,(
  thing.new {
    :nil
  }
))

f(%%
## w instance method, brace-block & having 1 arg
##
#> {:from => [54,2], :till => [56,3]}
##
%,(
  thing.new {|x|
    :nil
  }
))

f(%%
## w instance method, brace-block & having multiple args
##
#> {:from => [65,2], :till => [67,3]}
##
%,(
  thing.new {|x, y, z|
    :nil
  }
))
