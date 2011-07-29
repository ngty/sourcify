#!/bin/bash

echo ''
echo `gem env | grep 'INSTALLATION DIRECTORY' | sed 's/.*\/\(.*\)/\1:/'`
rm -rf ~/.ruby_inline/*ParseTree*

SKIPPABLE=`ruby -e '"".method(:to_i).source_location rescue puts "oops"'`

if [ -z "$SKIPPABLE" ]; then
  bacon spec/*/*/*_spec.rb spec/*/*_spec.rb
else
  echo "NOTE: This ruby doesn't support Method#to_source (& friends) !!"
  bacon spec/proc/*/*_spec.rb spec/proc/*_spec.rb
fi
