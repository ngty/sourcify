# coding: utf-8
require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

# Issue#15 @ https://github.com/ngty/sourcify/issues/15
describe "With unicode regexps" do

  should 'raise RegexpError w Proc#to_source' do
    lambda do
      lambda do
        # coding: utf-8
        /\p{Lu}/
      end.to_source
    end.should.raise(RegexpError)
  end

  should 'handle w Proc#to_raw_source' do
    lambda {
      # coding: utf-8
      /\p{Lu}/
    }.should.be having_raw_source(%(
    proc {
      # coding: utf-8
      /\\p{Lu}/
    }
    ))
  end

  should 'raise RegexpError w Proc#to_sexp' do
    lambda do
      lambda do
        # coding: utf-8
        /\p{Lu}/
      end.to_sexp
    end.should.raise(RegexpError)
  end

end
