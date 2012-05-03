# -*- encoding: utf-8 -*-

f(%%
## w declared recipient & method
##
#> {:from => [9,6], :till => [11,5]}
##
%,(
  b = Proc.new do
    :nil
  end
))

f(%%
## w implied self method
##
#> {:from => [20,6], :till => [22,5]}
##
%,(
  b = proc do
    :nil
  end
))

# __END__
