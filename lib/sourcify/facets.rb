if RUBY_VERSION.include?('1.8.6')

  unless 1.respond_to?(:pred)
    class Integer
      def pred
        self - 1
      end
    end
  end

  unless :a.respond_to?(:to_proc)
    class Symbol
      def to_proc
        Proc.new{|*args| args.shift.__send__(self, *args)}
      end
    end
  end

end

unless binding.respond_to?(:has_local_variable?)
  class Binding
    def has_local_variable?(name)
      check_str = "local_variables.include?(#{name})"
      self.eval(check_str) rescue eval(check_str, self)
    end
  end
end
