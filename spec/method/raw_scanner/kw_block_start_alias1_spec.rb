require File.expand_path('../spec_helper', __FILE__)

unless has_parsetree?
  describe "Method's raw scanner > keyword block start alias #1 (incrementing counter by 1)" do

    extend Sourcify::Method::Parser::RawScanner::Spec::KwBlockStartSupport
    behaves_like "Keyword block start alias #1 (incrementing counter by 1)"

    kw_block_start_alias1.each do |kw|
      should "increment counter with ... def #{kw} ..." do
        kw_block_start_counter(<<EOL
aa def #{kw} bb ...
cc
EOL
               ).should.equal([2,2])
      end

    end
  end
end
