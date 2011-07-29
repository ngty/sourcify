#!/bin/bash

echo ''
echo `gem env | grep 'INSTALLATION DIRECTORY' | sed 's/.*\/\(.*\)/\1:/'`
rm -rf ~/.ruby_inline/*ParseTree*

SKIPPABLE=`ruby -e '"".method(:to_i).source_location rescue puts "oops"'`

if [ -n $SKIPPABLE ]; then
  echo "NOTE: Method#to_source (& friends) not supported in this ruby !!"
  bacon spec/proc/*/*_spec.rb spec/proc/*_spec.rb
else
  bacon spec/*/*/*_spec.rb spec/*/*_spec.rb
fi
