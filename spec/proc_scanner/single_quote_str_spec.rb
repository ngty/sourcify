require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

unless has_parsetree?
describe 'Single quote strings (\', %q & %w)' do

  %w{~ ` ! @ # $ % ^ & * _ - + = \\ | ; : ' " , . ? /}.map{|w| [w,w] }.concat(
    [%w{( )}, %w{[ ]}, %w({ }), %w{< >}]
  ).each do |q1,q2|
    %w{q w}.each do |t|

      should "handle %#{t}#{q1}...#{q2} (wo escape (single))" do
        process(" xx %#{t}#{q1}hello#{q2} ").should.include([:sstring, "%#{t}#{q1}hello#{q2}"])
      end

      should "handle %#{t}#{q1}...#{q2} (wo escape (multiple))" do
        tokens = process(" xx %#{t}#{q1}hello#{q2} %#{t}#{q1}world#{q2} ")
        tokens.should.include([:sstring, "%#{t}#{q1}hello#{q2}"])
        tokens.should.include([:sstring, "%#{t}#{q1}world#{q2}"])
      end

      should "handle %#{t}#{q1}...#{q2} (w escape (single))" do
        process(" xx %#{t}#{q1}hel\\#{q2}lo#{q2} ").should.
          include([:sstring, "%#{t}#{q1}hel\\#{q2}lo#{q2}"])
      end

      should "handle %#{t}#{q1}...#{q2} (w escape (multiple))" do
        process(" xx %#{t}#{q1}h\\#{q2}el\\#{q2}lo#{q2} ").should.
          include([:sstring, "%#{t}#{q1}h\\#{q2}el\\#{q2}lo#{q2}"])
      end

      # NOTE: We are skipping '\\' cos %q\\\\ is always raise SyntaxError no matter
      # how many backslashes we add
      unless q1 == '\\'
        should "handle %#{t}#{q1}\\\\#{q2}" do
          process(" xx %#{t}#{q1}\\\\#{q2} %#{t}#{q2}lo#{q2} ").should.
            include([:sstring, "%#{t}#{q1}\\\\#{q2}"])
        end
      end

      should "handle %#{t}#{q1}#{q2}" do
        process(" xx %#{t}#{q1}#{q2} %#{t}#{q2}lo#{q2} ").should.
          include([:sstring, "%#{t}#{q1}#{q2}"])
      end

    end
  end

  should "handle '...' (wo escape (single))" do
    process(" xx 'hello' ").should.include([:sstring, "'hello'"])
  end

  should "handle '...' (wo escape (multiple))" do
    tokens = process(" xx 'hello' 'world' ")
    tokens.should.include([:sstring, "'hello'"])
    tokens.should.include([:sstring, "'world'"])
  end

  should "handle '...' (w escape (single))" do
    process(" xx 'hel\\'lo' ").should.include([:sstring, "'hel\\'lo'"])
  end

  should "handle '...' (w escape (multiple))" do
    process(" xx 'h\\'el\\'lo' ").should.include([:sstring, "'h\\'el\\'lo'"])
  end

  should "handle '\\\\'" do
    process(%q(
      aa '\\\\' 
      cc
      'dd'
    )).should.include([:sstring, "'\\\\'"])
  end

  should "handle ''" do
    process(%q(
      aa '' 
      cc
      'dd'
    )).should.include([:sstring, "''"])
  end

end
end
