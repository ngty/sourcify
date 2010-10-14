require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

unless has_parsetree?
describe 'Double quote strings (wo interpolation)' do

  %w{~ ` ! @ # $ % ^ & * _ - + = | \\ ; : ' " , . ? /}.map{|w| [w,w] }.concat(
    [%w{( )}, %w{[ ]}, %w({ }), %w{< >}]
  ).each do |q1,q2|
    ['Q', 'W', 'x', 'r', ''].each do |t|

      should "handle %#{t}#{q1}...#{q2} (wo escape (single))" do
        process(" xx; %#{t}#{q1}hello#{q2} ").should.include([:dstring, "%#{t}#{q1}hello#{q2}"])
      end

      should "handle %#{t}#{q1}...#{q2} (wo escape (multiple))" do
        tokens = process(" xx; %#{t}#{q1}hello#{q2} %#{t}#{q1}world#{q2}  ")
        tokens.should.include([:dstring, "%#{t}#{q1}hello#{q2}"])
        tokens.should.include([:dstring, "%#{t}#{q1}world#{q2}"])
      end

      # NOTE: We are skipping '\\' cos %Q\hel\\o\ is always raise SyntaxError no matter
      # how many backslashes we add
      unless q1 == '\\'

        should "handle %#{t}#{q1}...#{q2} (w escape (single))" do
          process(" xx; %#{t}#{q1}hel\\#{q2}lo#{q2} ").should.
            include([:dstring, "%#{t}#{q1}hel\\#{q2}lo#{q2}"])
        end

        should "handle %#{t}#{q1}...#{q2} (w escape (multiple))" do
          process(" xx; %#{t}#{q1}h\\#{q2}el\\#{q2}lo#{q2} ").should.
            include([:dstring, "%#{t}#{q1}h\\#{q2}el\\#{q2}lo#{q2}"])
        end

        should "handle %#{t}#{q1}\\\\#{q2}" do
          process(" xx; %#{t}#{q1}\\\\#{q2} %#{t}#{q2}lo#{q2} ").should.
            include([:dstring, "%#{t}#{q1}\\\\#{q2}"])
        end

        should "handle %#{t}#{q1}#{q2}" do
          process(" xx; %#{t}#{q1}#{q2} %#{t}#{q2}lo#{q2} ").should.
            include([:dstring, "%#{t}#{q1}#{q2}"])
        end

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
      process(%Q( xx; #{q}hel\\#{q}lo#{q} )).should.include([:dstring, %Q(#{q}hel\\#{q}lo#{q})])
    end

    should "handle #{q}...#{q} (w escape (multiple))" do
      process(%Q( xx; #{q}h\\#{q}el\\#{q}lo#{q} )).should.
        include([:dstring, %Q(#{q}h\\#{q}el\\#{q}lo#{q})])
    end

    should "handle #{q}\\\\#{q}" do
      process(%Q(
        aa; #{q}\\\\#{q} 
        cc
        #{q}dd#{q}
      )).should.include([:dstring, "#{q}\\\\#{q}"])
    end

    should "handle #{q}#{q}" do
      process(%Q(
        aa; #{q}#{q} 
        cc
        #{q}dd#{q}
      )).should.include([:dstring, "#{q}#{q}"])
    end

  end

end
end
