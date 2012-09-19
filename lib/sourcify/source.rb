module Sourcify
  class Source < Struct.new(:raw, :stripped)

    private :raw=, :stripped=

    def to_s
      raw
    end

    def strip
      Source.new(stripped, stripped)
    end

    def strip!
      self.replace(strip)
      nil
    end

    def to_str
      raw
    end

    def <=>(other)
      to_s <=> other.to_s
    end

    def ==(other)
      to_s == other.to_s
    end

    "".public_methods(false).select{|m| m.to_s.end_with?('!') }.each do |m_bang|
      next if [:strip!].include?(m_bang)
      m = m_bang.to_s.sub('!','')

      define_method(m_bang) do |*args|
        self.replace(send(m))
        nil
      end
    end

    "".public_methods(false).reject{|m| m.to_s.end_with?('!') }.each do |m|
      next if [:strip, :to_s, :to_str, :==, :<=>].include?(m)

      define_method(m) do |*args|
        Sourcify::Source.new(raw.send(m, *args), stripped.send(m, *args))
      end
    end

  end
end
