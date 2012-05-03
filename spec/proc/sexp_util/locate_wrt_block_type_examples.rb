# -*- encoding: utf-8 -*-

f(%%
## w do-block
##
#> {:from => [9,6], :till => [11,5]}
##
%,(
  b = proc do
    :nil
  end
))

f(%%
## w brace-block
##
#> {:from => [20,6], :till => [22,3]}
##
%,(
  b = proc {
    :nil
  }
))

# __END__
