require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Proc#to_source w specified {:strip_enclosure => ...}' do

  describe '>> w true' do

    options = {:strip_enclosure => true}

    should 'strip enclosing proc wo arg' do
      lambda { a+b }.should.be having_source('a+b', options)
    end

    should 'strip enclosing proc w arg' do
      lambda {|a| a+b }.should.be having_source('a+b', options)
    end

  end

  describe '>> w false' do

    options = {:strip_enclosure => false}

    should 'not strip enclosing proc wo arg' do
      lambda { a+b }.should.be having_source('proc { a+b }', options)
    end

    should 'not strip enclosing proc w arg' do
      lambda {|a| a+b }.should.be having_source('proc {|a| a+b }', options)
    end

  end

end
