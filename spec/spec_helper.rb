require 'rubygems'
require 'minitest/spec'
require File.expand_path('../../lib/sourcify', __FILE__)


module Sourcify
  module SpecHelper

    class << self
      attr_accessor :fixtures

      def reset_fixtures!
        self.fixtures = []
      end

      def add_fixture(description_and_expectation, block)
        lines = description_and_expectation.split("\n")

        fixtures << [
          lines.grep(/^#!! /).join("\n").gsub('#!! ','').strip,
          lines.grep(/^#>> /).join("\n").gsub('#>> ','').strip,
          block
        ]
      end

      def each_fixture
        fixtures.each {|*args| yield(*args) }
      end
    end

    def examplify_fixtures(name)
      SpecHelper.reset_fixtures!
      load File.expand_path("../fixtures/#{name}.rb", __FILE__)

      SpecHelper.each_fixture do |description, expected, block|
        it description do
          block.to_source.must_equal(expected)
        end
      end
    end

  end
end


def f(description_and_expectation, block)
  Sourcify::SpecHelper.add_fixture(description_and_expectation, block)
end
