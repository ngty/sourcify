require 'minitest/spec'
require File.expand_path('../../lib/sourcify', __FILE__)


module Sourcify
  module SpecHelper

    def example(paragraph, block)
      description, expected = extract_args(paragraph)

      expected.each do |type, val|
        send(:"example_for_#{type}", description, val, block)
      end
    end

  private

    def extract_args(paragraph)
      lines = paragraph.split("\n")

      description, evaluable, literal, error = %w{## #> #" #!}.map do |pfx|
        pattern = /^ *#{pfx} /
        lines.grep(pattern).map{|s| s.sub(pattern,'') }.join("\n")
      end

      unless error.empty?
        def error.to_constant
          Sourcify::SpecHelper.send(:constantize, self)
        end
      end

      [
        description,
        {
          :evaluable => evaluable,
          :literal => literal,
          :error => error
        }.reject{|k,v| v.empty? }
      ]
    end

  private

    def example_for_evaluable(description, expected, block)
      it description do
        process(block).must_equal(eval(expected))
      end
    end

    def example_for_literal(description, expected, block)
      it description do
        process(block).must_equal(expected)
      end
    end

    def example_for_error(description, expected, block)
      it description do
        lambda { process(block) }.must_raise(expected.to_constant)
      end
    end

  end
end

# __END__
