shared "Keyword block start alias #1 (incrementing counter by 1)" do
  kw_block_start_alias1.each do |kw|

    %w{_ x 1}.each do |c|
      should "not increment counter with ... (#{kw}#{c} ...)" do
        kw_block_start_counter(<<EOL
aa (#{kw}#{c} bb ... )
cc
EOL
               ).should.equal([0,0])
      end
    end

    should "increment counter with ... (#{kw} ...)" do
      kw_block_start_counter(<<EOL
aa (#{kw} bb ... )
cc
EOL
             ).should.equal([1,1])
    end

    should "increment counter with ... ; #{kw} ..." do
      kw_block_start_counter(<<EOL
aa; #{kw} bb ...
cc
EOL
             ).should.equal([1,1])
    end

    should "increment counter with ... \\n #{kw} ..." do
      kw_block_start_counter(<<EOL
aa
 #{kw} bb ...
cc
EOL
             ).should.equal([1,1])
    end

    should "increment counter with ... \\n \t #{kw} ..." do
      kw_block_start_counter(<<EOL
aa
 \t #{kw} bb ...
cc
EOL
             ).should.equal([1,1])
    end

    should "increment counter with ... , #{kw} ..." do
      kw_block_start_counter(<<EOL
aa , #{kw} bb ...
cc
EOL
             ).should.equal([1,1])
    end

    should "increment counter with ... = #{kw} ..." do
      kw_block_start_counter(<<EOL
aa = #{kw} bb ...
cc
EOL
             ).should.equal([1,1])
    end

    should "increment counter with ... do #{kw} ..." do
      kw_block_start_counter(<<EOL
aa do #{kw} bb ...
cc
EOL
             ).should.equal([2,2])
    end

    should "increment counter with ... then #{kw} ..." do
      kw_block_start_counter(<<EOL
aa then #{kw} bb ...
cc
EOL
             ).should.equal([1,1])
    end

  end
end
