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
      case src
      when '(irb)' then irb_content
      else file_content
      end
    end

    def irb_content
      IRB.CurrentContext.io.line(0 .. -1).join
    end

    def file_content
      ::File.read(src)
    end

  end
end
