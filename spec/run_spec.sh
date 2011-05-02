#!/bin/bash

echo ''
echo `gem env | grep 'INSTALLATION DIRECTORY' | sed 's/.*\/\(.*\)/\1:/'`
rm -rf ~/.ruby_inline/*ParseTree*
bacon spec/**/*_spec.rb
