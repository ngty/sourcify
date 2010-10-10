require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

unless has_parsetree?
describe "Keyword do alias #2 (increment do..end block counter by 0..1)" do

  behaves_like 'has started do...end counter'

  %w{while until for}.each do |kw|

    %w{_ x 1}.each do |c|
      should "not increment counter with ... (#{kw}#{c} ...)" do
        do_end_counter(<<EOL
aa (#{kw}#{c} bb ... )
cc
EOL
               ).should.equal([0,0])
      end
    end

    should "increment counter with ... (#{kw} ...)" do
      do_end_counter(<<EOL
aa (#{kw} bb ... )
cc
EOL
                    ).should.equal([0,1])
    end

    should "increment counter with ... ; #{kw} ..." do
      do_end_counter(<<EOL
aa; #{kw} bb ...
cc
EOL
                    ).should.equal([0,1])
    end

    should "increment counter with ... \\n #{kw} ..." do
      do_end_counter(<<EOL
aa
 #{kw} bb ...
cc
EOL
                    ).should.equal([0,1])
    end

    should "increment counter with ... \\n \t #{kw} ..." do
      do_end_counter(<<EOL
aa
 \t #{kw} bb ...
cc
EOL
                    ).should.equal([0,1])
    end

    should "increment counter with ... = #{kw} ..." do
    do_end_counter(<<EOL
aa = #{kw} bb ...
cc
EOL
                  ).should.equal([0,1])
    end

    should "increment counter with ... , #{kw} ..." do
    do_end_counter(<<EOL
aa , #{kw} bb ...
cc
EOL
                  ).should.equal([0,1])
    end

    should "increment counter with ... do #{kw} ..." do
    do_end_counter(<<EOL
aa do #{kw} bb ...
cc
EOL
                  ).should.equal([1,2])
    end

    should "increment counter with ... then #{kw} ..." do
      do_end_counter(<<EOL
aa then #{kw} bb ...
cc
EOL
                    ).should.equal([0,1])
    end

  end
end
end
