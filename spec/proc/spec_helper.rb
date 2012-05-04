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

        end
      end
    end
  end
end
