require 'forwardable'

module Sourcify
  class Source < Struct.new(:raw, :stripped)

    extend Forwardable
    def_delegators :raw, *("".public_methods(false) - [:strip, :strip!])

    private :raw=, :stripped=

    def strip
      Source.new(stripped, stripped)
    end

    def strip!
      self.replace(strip); nil
    end

  end
end
