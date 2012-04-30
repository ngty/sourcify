require File.expand_path('../../spec_helper', __FILE__)

module Sourcify
  module Proc
    module SpecHelper
      def self.extended(example_group)
        example_group.class_eval do

          extend Sourcify::SpecHelper

          def self.load_examples_file(name)
            load File.expand_path("../#{name}_examples.rb", __FILE__)
          end

          def self.example_for_source(description, expected, block)
            it description do
              process(block).must_equal(eval(expected))
            end
          end

        end
      end
    end
  end
end
