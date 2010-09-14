require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'lib', 'sourcify')
require 'benchmark'
require 'pp'

if RUBY_PLATFORM =~ /java/i
  require 'jruby'
  JRuby.objectspace = true
  reload! rescue nil
end

DUMPED_OBJECT_SPACE_PROCS = {:max => nil, :done => 0}
DUMP_OBJECT_SPACE_PROCS_ERRORS = []
class STOP_DUMPING_OBJECT_SPACE_PROCS < Exception; end

def dump_object_space_procs(debug = false)
  # Determine working dir
  name = [
    RUBY_DESCRIPTION =~ /enterprise/i ? 'ree' : (RUBY_PLATFORM =~ /java/i ? 'jruby' : 'mri'),
    RUBY_VERSION,
    Object.const_defined?(:ParseTree) ? 'parsetree' : nil
  ].compact.join('~')
  dump_dir = File.join(File.dirname(File.expand_path(__FILE__)), '..', 'tmp', name)
  Dir.mkdir(dump_dir) unless File.exists?(dump_dir)

  puts '',
    '== NOTE: dump files can be found at %s' % dump_dir

  # Core processing
  ObjectSpace.each_object(Proc).to_a.select{|o| o.source_location }.
    group_by{|o| o.source_location[0] }.each do |ofile, objs|
      nfile = File.join(dump_dir, ofile.gsub('/','~'))
      File.open(nfile,'w') do |f|
        objs.sort_by{|o| o.source_location[1] }.map do |o|
          DUMPED_OBJECT_SPACE_PROCS[:done] += 1
          begin
            data = {
              :location => o.source_location,
              :sexp => o.to_sexp,
              :source => o.to_source
            }
            f.puts(data.pretty_inspect)
            print '.'
          rescue Exception
            data = {
              :location => o.source_location,
              :error => $!.inspect
            }
            DUMP_OBJECT_SPACE_PROCS_ERRORS << data
            f.puts(data.pretty_inspect)
            pp(data) if debug
            print 'x'
          ensure
            raise STOP_DUMPING_OBJECT_SPACE_PROCS \
              if DUMPED_OBJECT_SPACE_PROCS.values.uniq.size == 1
          end
        end
      end
    end
end

# Dumping in action
figures = Benchmark.measure do
  begin
    dump_object_space_procs
  rescue STOP_DUMPING_OBJECT_SPACE_PROCS
  end
end

# Printout the failures/passes
unless DUMP_OBJECT_SPACE_PROCS_ERRORS.empty?
  puts '', '== OOPS, we have some erorrs :('
  DUMP_OBJECT_SPACE_PROCS_ERRORS.each_with_index do |e, i|
    print "#{i}). %s" % e.pretty_inspect
  end
else
  puts '', '== YEAH, no errors :)'
end

# Printout the benchmark results
puts '',
  '== Benchmark results for processing %s procs:' % DUMPED_OBJECT_SPACE_PROCS[:done],
  figures.to_s, ''

# __END__
