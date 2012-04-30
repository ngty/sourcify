# -*- encoding: utf-8 -*-

f(%%
## w do-block
##
#> {:from => [9,2], :till => [11,5]}
##
%,(
  proc do
    :nil
  end
))

f(%%
## w brace-block
##
#> {:from => [20,2], :till => [22,3]}
##
%,(
  proc {
    :nil
  }
))

# __END__
