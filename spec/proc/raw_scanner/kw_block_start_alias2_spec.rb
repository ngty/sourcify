require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Proc's raw scanner > keyword block start alias #2 (incrementing counter by 0..1)" do

    extend Sourcify::Proc::Parser::RawScanner::Spec::KwBlockStartSupport
    behaves_like "Keyword block start alias #2 (incrementing counter by 0..1)"

    kw_block_start_alias2.each do |kw|
      should "increment counter with ... do #{kw} ..." do
      kw_block_start_counter(<<EOL
aa do #{kw} bb ...
cc
EOL
                    ).should.equal([1,2])
      end
    end

  end
end
