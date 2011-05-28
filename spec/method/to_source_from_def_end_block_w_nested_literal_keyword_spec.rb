require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_source from def ... end block (w nested literal keyword)" do

  # See http://redmine.ruby-lang.org/issues/show/3764

  should 'handle :class' do
    def m1
      x = :class
    end
    method(:m1).should.be having_source(%(
      def m1
        x = :class
      end
    ))
  end

  should 'handle :module' do
    def m2
      x = :module
    end
    method(:m2).should.be having_source(%(
      def m2
        x = :module
      end
    ))
  end

  should 'handle :def' do
    def m3
      x = :def
    end
    method(:m3).should.be having_source(%(
      def m3
        x = :def
      end
    ))
  end

  should 'handle :if' do
    def m4
      x = :if
    end
    method(:m4).should.be having_source(%(
      def m4
        x = :if
      end
    ))
  end

  should 'handle :unless' do
    def m5
      x = :unless
    end
    method(:m5).should.be having_source(%(
      def m5
        x = :unless
      end
    ))
  end

  should 'handle :for' do
    def m6
      x = :for
    end
    method(:m6).should.be having_source(%(
      def m6
        x = :for
      end
    ))
  end

  should 'handle :while' do
    def m7
      x = :while
    end
    method(:m7).should.be having_source(%(
      def m7
        x = :while
      end
    ))
  end

  should 'handle :until' do
    def m8
      x = :until
    end
    method(:m8).should.be having_source(%(
      def m8
        x = :until
      end
    ))
  end

  should 'handle :begin' do
    def m9
      x = :begin
    end
    method(:m9).should.be having_source(%(
      def m9
        x = :begin
      end
    ))
  end

  should 'handle :case' do
    def m10
      x = :case
    end
    method(:m10).should.be having_source(%(
      def m10
        x = :case
      end
    ))
  end

  should 'handle :do' do
    def m11
      x = :do
    end
    method(:m11).should.be having_source(%(
      def m11
        x = :do
      end
    ))
  end

  should 'handle :end' do
    def m12
      x = :end
    end
    method(:m12).should.be having_source(%(
      def m12
        x = :end
      end
    ))
  end

end
