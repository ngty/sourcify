SOURCIFY_RB = File.expand_path('../../lib/sourcify', __FILE__)

require 'minitest/spec'
require SOURCIFY_RB

module Sourcify
  module SpecHelper

    def self.extended(base)
      base.class_eval do
        include InstanceMethods
        extend ClassMethods
      end
    end

    module InstanceMethods

      def irb_exec(string)
        eval_output <<-`SHELL`
(
cat <<-RUBY
  #{string}
RUBY
) | irb -r #{SOURCIFY_RB} --simple-prompt
        SHELL
      end

      def pry_exec(string)
        eval_output <<-`SHELL`
(
cat <<-RUBY
  #{string}
RUBY
) | pry -r #{SOURCIFY_RB} --simple-prompt --no-color
        SHELL
      end

    private

      def eval_output(output)
        lines = output.split("\n")
        i = lines.rindex{|l| l.start_with?('=>') }
        eval(lines[i .. -1].map{|l| l[3 .. -1] } * "\n")
      end

    end

    module ClassMethods

      def example(paragraph, block)
        description, expected = extract_args(paragraph)
        debug_line = caller[0].split(':')[1]
        description += " (at line #{debug_line})"

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
            self.to_s.split('::').inject(Object) do |klass, const|
              klass.const_get(const)
            end
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
end

# __END__
