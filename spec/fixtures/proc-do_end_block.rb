# -*- encoding: utf-8 -*-

f("
#!! wo argument
#>> lambda do
#>>   x + 1
#>> end",
lambda do
  x + 1
end
)

f("
#!! w 1 argument
#>> lambda do |x|
#>>   x + 1
#>> end",
lambda do |x|
  x + 1
end
)

