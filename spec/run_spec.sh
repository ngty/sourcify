#!/bin/bash

echo ''
echo `gem env | grep 'INSTALLATION DIRECTORY' | sed 's/.*\/\(.*\)/\1:/'`
rm -rf ~/.ruby_inline/*ParseTree*

if [ "${METHOD_TO_SOURCE}" == "true" ]; then
  bacon spec/{proc,method}/*/*_spec.rb spec/{proc,method}/*_spec.rb
else
  echo "NOTE: This ruby doesn't support Method#to_source (& friends) !!"
  bacon spec/proc/*/*_spec.rb spec/{proc,no_method}/*_spec.rb
fi
