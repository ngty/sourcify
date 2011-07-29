#!/bin/bash

echo ''
echo `gem env | grep 'INSTALLATION DIRECTORY' | sed 's/.*\/\(.*\)/\1:/'`
rm -rf ~/.ruby_inline/*ParseTree*

SKIPPABLE=`ruby -e 'm = 1.method(:to_s); (m.source_location; m.parameters) rescue puts "oops"'`

if [ -z "$SKIPPABLE" ]; then
  bacon spec/*/*/*_spec.rb spec/*/*_spec.rb
else
  echo "NOTE: This ruby doesn't support Method#to_source (& friends) !!"
  bacon spec/proc/*/*_spec.rb spec/proc/*_spec.rb
fi
