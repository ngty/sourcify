# -*- encoding: utf-8 -*-

f(%%
## w no arg
##
#> {:from => [9,2], :till => [11,5]}
##
%,(
  proc do
    :nil
  end
))

f(%%
## w 1 arg
##
#> {:from => [20,2], :till => [22,5]}
##
%,(
  proc do |x|
    :nil
  end
))

f(%%
## w multiple args
##
#> {:from => [31,2], :till => [33,5]}
##
%,(
  proc do |x, y, z|
    :nil
  end
))

# __END__
