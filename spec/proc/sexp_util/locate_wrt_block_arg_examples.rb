# -*- encoding: utf-8 -*-

f(%%
## w no arg
##
#> {:from => [9,6], :till => [11,5]}
##
%,(
  b = proc do
    :nil
  end
))

f(%%
## w 1 arg
##
#> {:from => [20,6], :till => [22,5]}
##
%,(
  b = proc do |x|
    :nil
  end
))

f(%%
## w multiple args
##
#> {:from => [31,6], :till => [33,5]}
##
%,(
  b = proc do |x, y, z|
    :nil
  end
))

f(%%
## w only splat args
##
#> {:from => [42,6], :till => [44,5]}
##
%,(
  b = proc do |*x|
    :nil
  end
))

f(%%
## w multiple & splat args
##
#> {:from => [53,6], :till => [55,5]}
##
%,(
  b = proc do |x, y, *z|
    :nil
  end
))

# __END__
