require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_source from def...end w single blocks and many matches' do

  should 'skip non-matching w no nesting on same line' do
    def m1(a); @x1; end; def m1(b); @x2; end
    method(:m1).should.be having_source(%(
      def m1(b)
        @x2
      end
    ))
  end

  should 'skip non-matching w single level nesting on same line' do
    def m2(a); class << self; def m2(b); @x1; end; end; end
    m2(1) # calling m2 has the side effect of redefining m2
    method(:m2).should.be having_source(%(
      def m2(b)
        @x1
      end
    ))
  end

  should 'skip non-matching w multi level nesting on same line' do
    def m3(a); class << self; def m3(b); class << self; def m3(c); @x1; end; end; end; end; end
    m3(1); m3(2) # calling m3 twice has the side effect of redefining m3 twice
    method(:m3).should.be having_source(%(
      def m3(c)
        @x1
      end
    ))
  end

end
