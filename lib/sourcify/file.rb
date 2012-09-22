require 'stringio'

module Sourcify
  class File < Struct.new(:block)

    def open(&process)
      StringIO.open(content, &process)
    end

    def src
      block.source_location[0]
    end

    def line
      block.source_location[1]
    end

  private

    def content
      ::File.read(src)
    end

  end
end
