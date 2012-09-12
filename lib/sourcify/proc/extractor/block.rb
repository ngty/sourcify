require 'ripper'

module Sourcify
  module Proc
    module Extractor
      class Block

        def initialize(type, frag)
          @type, @encoding, @frags = type, frag.encoding, [frag]
          @valid, @dubious = true, false
        end

        def dubious?
          !!@dubious
        end

        def invalid?
          !@valid
        end

        def lambda_op?
          @is_lambda_op ||= @frags[0] == '->'
        end

        def <<(frag)
          @frags << frag
        end

        def done?
          if invalid?
            true
          else
            @done ||=
              begin
                if %w(} end).include?(@frags[-1]) && !!Ripper.sexp(s = body)
                  !!(@body = s)
                end
              rescue
                nil
              end
          end
        end

        def body
          @body ||
            begin
              block = lambda_op? ? lambda_op_body : %( #{@frags*''})

              if @frags[0] == '{' && expr = Ripper.sexp(block)
                if expr[1] && (e = expr[1][0])[0] == :hash
                  if e[1].nil?
                    @dubious = true
                  else
                    @valid = false; return
                  end
                end
              end

              (@type + block).force_encoding(@encoding)
            end
        end

        def params
          instance_eval(body).parameters
        end

      private

        def lambda_op_body
          case @frags[1]
          when '('
            frags = @frags.dup
            i_rparen, i_do, i_lbrace = %w") do {".map{|s| frags.index(s) }
            i_nl = frags[0..i_rparen].rindex("\n")
            frags[i_nl] = "\\" + frags[i_nl] if i_nl

            if i_do && (i_lbrace.nil? || i_do < i_lbrace)
               %( do |#{frags[2...i_rparen]*''}|#{frags[(i_do+1)..-1]*''})
            else
               %( { |#{frags[2...i_rparen]*''}|#{frags[(i_lbrace+1)..-1]*''})
            end
          when / +/
            %(#{@frags[1..-1]*''})
          else
            %( #{@frags[1..-1]*''})
          end
        end

      end
    end
  end
end
