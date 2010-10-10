require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Proc#to_source from do ... end block (w nested literal keyword)" do

  # See http://redmine.ruby-lang.org/issues/show/3764

  should 'handle :class' do
    (
      lambda do
        x = :class
      end
    ).should.be having_source('proc { x = :class }')
  end

  should 'handle :module' do
    (
      lambda do
        x = :module
      end
    ).should.be having_source('proc { x = :module }')
  end

  should 'handle :def' do
    (
      lambda do
        x = :def
      end
    ).should.be having_source('proc { x = :def }')
  end

  should 'handle :if' do
    (
      lambda do
        x = :if
      end
    ).should.be having_source('proc { x = :if }')
  end

  should 'handle :unless' do
    (
      lambda do
        x = :unless
      end
    ).should.be having_source('proc { x = :unless }')
  end

  should 'handle :for' do
    (
      lambda do
        x = :for
      end
    ).should.be having_source('proc { x = :for }')
  end

  should 'handle :while' do
    (
      lambda do
        x = :while
      end
    ).should.be having_source('proc { x = :while }')
  end

  should 'handle :until' do
    (
      lambda do
        x = :until
      end
    ).should.be having_source('proc { x = :until }')
  end

  should 'handle :begin' do
    (
      lambda do
        x = :begin
      end
    ).should.be having_source('proc { x = :begin }')
  end

  should 'handle :case' do
    (
      lambda do
        x = :case
      end
    ).should.be having_source('proc { x = :case }')
  end

  should 'handle :do' do
    (
      lambda do
        x = :do
      end
    ).should.be having_source('proc { x = :do }')
  end

  should 'handle :end' do
    (
      lambda do
        x = :end
      end
    ).should.be having_source('proc { x = :end }')
  end

end
