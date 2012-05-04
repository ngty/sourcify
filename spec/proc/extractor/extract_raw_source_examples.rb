# -*- encoding: utf-8 -*-

f(%%
## wo comment
##
#" lambda do |x|
#"   :nil
#" end
##
%,(
  b = lambda do |x|
    :nil
  end
))

f(%%
## w comment
##
#" lambda do |x|
#"   # ignore me
#"   :nil
#" end
##
%,(
  b = lambda do |x|
    # ignore me
    :nil
  end
))

# __END__
