# -*- encoding: utf-8 -*-

f(%%
## w declared recipient & method
##
#> {:from => [9,2], :till => [11,5]}
##
%,(
  Proc.new do
    :nil
  end
))

f(%%
## w implied self method
##
#> {:from => [20,2], :till => [22,5]}
##
%,(
  proc do
    :nil
  end
))

# __END__
