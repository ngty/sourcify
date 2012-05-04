# -*- encoding: utf-8 -*-

f(%%
## wo comment
##
#> lambda { |x| :nil }
##
%,(
  b = lambda do |x|
    :nil
  end
))

f(%%
## w comment
##
#> lambda { |x| :nil }
##
%,(
  b = lambda do |x|
    # ignore me
    :nil
  end
))

# __END__
