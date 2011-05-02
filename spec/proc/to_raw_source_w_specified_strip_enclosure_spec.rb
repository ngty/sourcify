require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_raw_source w specified {:strip_enclosure => ...}' do

  describe '>> w true' do

    options = {:strip_enclosure => true}

    should 'strip enclosing proc wo arg' do
      (
        lambda do
          a = 1
          # i should stay !!
        end
      ).should.be having_raw_source(%(
          a = 1
          # i should stay !!
      ), options)
    end

    should 'strip enclosing proc w arg' do
      (
        lambda do |a|
          a = 1
          # i should stay !!
        end
      ).should.be having_raw_source(%(
          a = 1
          # i should stay !!
      ), options)
    end

  end

  describe '>> w false' do

    options = {:strip_enclosure => false}

    should 'not strip enclosing proc wo arg' do
      (
        lambda do
          a = 1
          # i should stay !!
        end
      ).should.be having_raw_source(%(
        proc do
          a = 1
          # i should stay !!
        end
      ), options)
    end

    should 'not strip enclosing proc w arg' do
      (
        lambda do |a|
          a = 1
          # i should stay !!
        end
      ).should.be having_raw_source(%(
        proc do |a|
          a = 1
          # i should stay !!
        end
      ), options)
    end

  end

end
