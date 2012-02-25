# -*- encoding: utf-8 -*-

f("
#!! wo argument
#>> lambda do
#>>   x + 1
#>> end",
lambda {
  x + 1
}
)

f("
#!! w 1 argument
#>> lambda do |x|
#>>   x + 1
#>> end",
lambda { |x|
  x + 1
}
)

