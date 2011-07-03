require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_sexp w specified {:strip_enclosure => ...} (from def..end block)' do

  describe '>> w true' do

    options = {:strip_enclosure => true}

    should 'strip enclosing proc wo arg' do
      def m1; a+b; end
      method(:m1).should.be having_sexp(
        s(:scope,
          s(:block,
            s(:call,
              s(:call, nil, :a, s(:arglist)),
              :+,
              s(:arglist, s(:call, nil, :b, s(:arglist)))))),
        options
      )
    end

    should 'strip enclosing proc w arg' do
      def m2(a); a+b; end
      method(:m2).should.be having_sexp(
        s(:scope,
          s(:block,
            s(:call,
              s(:lvar, :a),
              :+,
              s(:arglist, s(:call, nil, :b, s(:arglist)))))),
        options
      )
    end

  end

  describe '>> w false' do

    options = {:strip_enclosure => false}

    should 'not strip enclosing proc wo arg' do
      def m3; a+b; end
      method(:m3).should.be having_sexp(
        s(:defn,
          :m3,
          s(:args),
          s(:scope,
            s(:block,
              s(:call,
                s(:call, nil, :a, s(:arglist)),
                :+,
                s(:arglist, s(:call, nil, :b, s(:arglist))))))),
        options
      )
    end

    should 'not strip enclosing proc w arg' do
      def m4(a); a+b; end
      method(:m4).should.be having_sexp(
        s(:defn,
          :m4,
          s(:args, :a),
          s(:scope,
             s(:block,
                 s(:call, s(:lvar, :a), :+, s(:arglist, s(:call, nil, :b, s(:arglist))))))),
        options
      )
    end

  end

end
