#!/bin/bash
if [ -z "$TRAVIS" ]; then
  echo ''
  echo `gem env | grep 'INSTALLATION DIRECTORY' | sed 's/.*\/\(.*\)/\1:/'`
  rm -rf ~/.ruby_inline/*ParseTree*
fi

SUPPORTS_METHOD_TO_SOURCE=`ruby -e '
  begin
    [:source_location, :parameters].each{|meth| 1.method(:to_s).send(meth) }
    raise RuntimeError if RUBY_PLATFORM =~ /java/i
    puts :true
  rescue NoMethodError, RuntimeError
    puts :false
  end
'`

if [ "$SUPPORTS_METHOD_TO_SOURCE" == "true" ]; then
  bundle exec bacon spec/{proc,method}/*/*_spec.rb spec/{proc,method}/*_spec.rb
else
  echo "NOTE: This ruby doesn't support Method#to_source (& friends) !!"
  bundle exec bacon spec/proc/*/*_spec.rb spec/{proc,no_method}/*_spec.rb
fi

# __END__
