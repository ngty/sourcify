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

      def add_fixture(paragraph, block)
        description, expected = extract_args(paragraph)
        fixtures << [description, expected, block]
      end

      def each_fixture
        fixtures.each {|*args| yield(*args) }
      end

    private

      def extract_args(paragraph)
        lines = paragraph.split("\n")

        description, source, error = %w{## #> #!}.map do |pfx|
          pattern = /^#{pfx} /
          lines.grep(pattern).map{|s| s.sub(pattern,'') }.join("\n")
        end

        unless error.empty?
          def error.to_constant
            Sourcify::SpecHelper.send(:constantize, self)
          end
        end

        [
          description,
          {:source => source, :error => error}.reject{|k,v| v.empty? }
        ]
      end

      def constantize(string)
        string.split('::').inject(Object) do |klass, constant|
          klass.const_get(constant)
        end
      end

    end

    def run_examples(name)
      SpecHelper.reset_fixtures!
      load File.expand_path("../fixtures/#{name}.rb", __FILE__)

      SpecHelper.each_fixture do |description, expected, block|
        expected.each do |type, val|
          send(:"example_for_#{type}", description, val, block)
        end
      end
    end

  private

    def example_for_source(description, expected, block)
      it description do
        block.to_source.must_equal(expected)
      end
    end

    def example_for_error(description, expected, block)
      it description do
        lambda { block.to_source }.must_raise(expected.to_constant)
      end
    end

  end
end

def f(paragraph, block)
  Sourcify::SpecHelper.add_fixture(paragraph, block)
end

