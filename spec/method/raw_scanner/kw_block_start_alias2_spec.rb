require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Method's raw scanner > keyword block start alias #2 (incrementing counter by 0..1)" do

    extend Sourcify::Method::Parser::RawScanner::Spec::KwBlockStartSupport
    behaves_like "Keyword block start alias #2 (incrementing counter by 0..1)"

    kw_block_start_alias2.each do |kw|
      should "increment counter with ... def #{kw} ..." do
      kw_block_start_counter(<<EOL
aa def #{kw} bb ...
cc
EOL
                    ).should.equal([1,2])
      end
    end

  end
end
