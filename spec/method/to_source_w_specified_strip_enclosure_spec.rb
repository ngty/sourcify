require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source' do
  describe 'w specified {:strip_enclosure => ...}' do

    describe '>> w true' do

      options = {:strip_enclosure => true}

      should 'strip enclosing proc wo arg' do
        def m1; a+b; end
        method(:m1).should.be having_source(%(a + b), options)
      end

      should 'strip enclosing proc w arg' do
        def m2(a); a+b; end
        method(:m2).should.be having_source(%(a+b), options)
      end

    end

    describe '>> w false' do

      options = {:strip_enclosure => false}

      should 'not strip enclosing proc wo arg' do
        def m3; a+b; end
        method(:m3).should.be having_source(%(def m3; a+b; end), options)
      end

      should 'not strip enclosing proc w arg' do
        def m4(a); a+b; end
        method(:m4).should.be having_source(%(def m4(a); a+b; end), options)
      end

    end

  end
end
