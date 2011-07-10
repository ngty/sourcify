require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe 'Method#to_raw_source' do
  describe 'w specified {:strip_enclosure => ...}' do

    describe '>> w true' do

      options = {:strip_enclosure => true}

      should 'strip enclosing def..end wo arg' do
        def m
          # i should stay !!
        end
        method(:m).should.be having_raw_source('# i should stay !!', options)
      end

      should 'strip enclosing def..end w 1 required arg' do
        def m(aa)
          # i should stay !!
        end
        method(:m).should.be having_raw_source('# i should stay !!', options)
      end

      should 'strip enclosing def..end w 1 optional arg' do
        def m(aa = nil)
          # i should stay !!
        end
        method(:m).should.be having_raw_source('# i should stay !!', options)
      end

      should 'strip enclosing def..end w 1 splat arg' do
        def m(*aa)
          # i should stay !!
        end
        method(:m).should.be having_raw_source('# i should stay !!', options)
      end

      should 'strip enclosing def..end w 1 bracketed arg' do
        def m((aa, bb))
          # i should stay !!
        end
        method(:m).should.be having_raw_source('# i should stay !!', options)
      end

      should 'strip enclosing def..end w 1 required & 1 optional' do
        def m(aa, bb = nil)
          # i should stay !!
        end
        method(:m).should.be having_raw_source('# i should stay !!', options)
      end

      should 'strip enclosing def..end w 1 required & 1 splat' do
        def m(aa, *bb)
          # i should stay !!
        end
        method(:m).should.be having_raw_source('# i should stay !!', options)
      end

      should 'strip enclosing def..end w 1 required & 1 bracketed' do
        def m(aa, (bb, cc))
          # i should stay !!
        end
        method(:m).should.be having_raw_source('# i should stay !!', options)
      end

      should 'strip enclosing def..end even wo parenthesis' do
        def m aa
          # i should stay !!
        end
        method(:m).should.be having_raw_source('# i should stay !!', options)
      end

    end

    describe '>> w false' do

      options = {:strip_enclosure => false}

      should 'not strip enclosing def..end wo arg' do
        def m
          # i should stay !!
        end
        method(:m).should.be having_raw_source(%(
        def m
          # i should stay !!
        end
        ), options)
      end

      should 'not strip enclosing def..end w 1 required arg' do
        def m(aa)
          # i should stay !!
        end
        method(:m).should.be having_raw_source(%(
        def m(aa)
          # i should stay !!
        end
        ), options)
      end

      should 'not strip enclosing def..end w 1 optional arg' do
        def m(aa = nil)
          # i should stay !!
        end
        method(:m).should.be having_raw_source(%(
        def m(aa = nil)
          # i should stay !!
        end
        ), options)
      end

      should 'not strip enclosing def..end w 1 splat arg' do
        def m(*aa)
          # i should stay !!
        end
        method(:m).should.be having_raw_source(%(
        def m(*aa)
          # i should stay !!
        end
        ), options)
      end

      should 'not strip enclosing def..end w 1 bracketed arg' do
        def m((aa, bb))
          # i should stay !!
        end
        method(:m).should.be having_raw_source(%(
        def m((aa, bb))
          # i should stay !!
        end
        ), options)
      end

      should 'not strip enclosing def..end even wo parenthesis' do
        def m aa
          # i should stay !!
        end
        method(:m).should.be having_raw_source(%(
        def m aa
          # i should stay !!
        end
        ), options)
      end

    end

  end
end
