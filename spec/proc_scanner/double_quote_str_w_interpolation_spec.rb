require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

unless has_parsetree?
describe 'Double quote strings (w interpolation)' do

  # NOTE: we skip %Q#...# cos %Q#..#{..}..# is invalid syntax.
  %w{~ ` ! @ $ % ^ & * _ - + = | ; : ' " , . ? / \\}.map{|w| [w,w] }.concat(
    [%w{( )}, %w{[ ]}, %w({ }), %w{< >}]
  ).each do |q1,q2|
    ['Q', 'W', 'x', 'r', ''].each do |t|

      should "handle %#{t}#{q1}...#{q2} (wo nesting (single))" do
        process(" xx; %#{t}#{q1}h\#{%#{t}#{q1}ell#{q2}}o#{q2} ").
          should.include([:dstring, "%#{t}#{q1}h\#{%#{t}#{q1}ell#{q2}}o#{q2}"])
      end

      should "handle %#{t}#{q1}...#{q2} (wo nesting (multiple))" do
        tokens = process(" xx;  %#{t}#{q1}h\#{%#{t}#{q1}ell#{q2}}o#{q2} %#{t}#{q1}w\#{%#{t}#{q1}orl#{q2}}d#{q2}  ")
        tokens.should.include([:dstring, "%#{t}#{q1}h\#{%#{t}#{q1}ell#{q2}}o#{q2}"])
        tokens.should.include([:dstring, "%#{t}#{q1}w\#{%#{t}#{q1}orl#{q2}}d#{q2}"])
      end

      should "handle %#{t}#{q1}...#{q2} (w nesting (single))" do
        process(" xx; %#{t}#{q1}h\#{%#{t}#{q1}e\#{%#{t}#{q1}l#{q2}}l#{q2}}o#{q2} ").
          should.include([:dstring, "%#{t}#{q1}h\#{%#{t}#{q1}e\#{%#{t}#{q1}l#{q2}}l#{q2}}o#{q2}"])
      end

      should "handle %#{t}#{q1}...#{q2} (w nesting (multiple))" do
        tokens = process(" xx; " +
          "%#{t}#{q1}h\#{%#{t}#{q1}e\#{%#{t}#{q1}l#{q2}}l#{q2}}o#{q2} " +
          "%#{t}#{q1}w\#{%#{t}#{q1}o\#{%#{t}#{q1}r#{q2}}l#{q2}}d#{q2} "
        )
        tokens.should.include([:dstring, "%#{t}#{q1}h\#{%#{t}#{q1}e\#{%#{t}#{q1}l#{q2}}l#{q2}}o#{q2}"])
        tokens.should.include([:dstring, "%#{t}#{q1}w\#{%#{t}#{q1}o\#{%#{t}#{q1}r#{q2}}l#{q2}}d#{q2}"])
      end

    end
  end

  %w{" / `}.each do |q|

    should "handle #{q}...#{q} (wo escape (single))" do
      process(%Q( xx; #{q}hello#{q} )).should.include([:dstring, %Q(#{q}hello#{q})])
    end

    should "handle #{q}...#{q} (wo escape & multiple)" do
      tokens = process(%Q( xx; #{q}hello#{q} ; #{q}world#{q} ))
      tokens.should.include([:dstring, %Q(#{q}hello#{q})])
      tokens.should.include([:dstring, %Q(#{q}world#{q})])
    end

    should "handle #{q}...#{q} (w escape (single))" do
      process(%Q( xx; #{q}hel\\#{q}lo#{q} )).should.
        include([:dstring, %Q(#{q}hel\\#{q}lo#{q})])
    end

    should "handle #{q}...#{q} (w escape (multiple))" do
      process(%Q( xx; #{q}h\\#{q}el\\#{q}lo#{q} )).should.include([:dstring, %Q(#{q}h\\#{q}el\\#{q}lo#{q})])
    end

  end

end
end
