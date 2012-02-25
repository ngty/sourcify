require File.expand_path('../spec_helper', __FILE__)

describe 'Proc w do..end block' do
  extend Sourcify::SpecHelper
  examplify_fixtures 'proc-do_end_block'
end

describe 'Proc w {..} block' do
  extend Sourcify::SpecHelper
  examplify_fixtures 'proc-braced_block'
end
