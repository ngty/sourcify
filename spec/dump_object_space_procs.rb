require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'lib', 'sourcify')
require 'pp'

def dump_object_space_procs(debug = false)
  puts ''
  errors = []

  # Determine working dir
  name = [
    RUBY_DESCRIPTION =~ /enterprise/i ? 'ree' : (RUBY_PLATFORM =~ /java/i ? 'jruby' : 'mri'),
    RUBY_VERSION,
    Object.const_defined?(:ParseTree) ? 'parsetree' : nil
  ].compact.join('~')
  dump_dir = File.join(File.dirname(File.expand_path(__FILE__)), '..', 'tmp', name)
  Dir.mkdir(dump_dir) unless File.exists?(dump_dir)

  # Core processing
  ObjectSpace.each_object(Proc).to_a.
    group_by{|o| o.source_location[0] }.each do |ofile, objs|
      nfile = File.join(dump_dir, ofile.gsub('/','~'))
      puts '',
        '>> PROCESSING %s ...' % ofile,
        ">> DUMPING %s ..." % nfile

      File.open(nfile,'w') do |f|
        objs.sort_by{|o| o.source_location[1] }.map do |o|
          data =
            begin
              {
                :location => o.source_location,
                :sexp => o.to_sexp,
                :source => o.to_source
              }
            rescue Exception
              errors << {
                :location => o.source_location,
                :error => $!.inspect
              }
              errors.last
            end
          f.puts(data.pretty_inspect)
          debug ? pp(data) : print('.')
        end
      end
    end

  puts '',''
  unless errors.empty?
    puts '== OOPS, we have some erorrs :('
    errors.each_with_index{|e, i| print "#{i}). "; pp e }
  else
    puts '== YEAH, no errors :)'
  end
  puts '',''
end

dump_object_space_procs
