require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe "Method#to_source (from def ... end block)" do
  describe "w 19 extras" do
    if RUBY_VERSION.include?('1.9.')

      should 'handle simple (w label keys)' do
        def m1; {a: 1, b: 2}; end
        method(:m1).should.be having_source(%(
          def m1; {:a => 1, :b => 2}; end
        ))
      end

      should 'handle nested (w label keys)' do
        def m2; {a: 1, b: {c: 3}}; end
        method(:m2).should.be having_source(%(
          def m2; {:a => 1, :b => {:c => 3}}; end
        ))
      end

    end
  end
end
