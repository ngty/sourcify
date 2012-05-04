require "bundler/gem_tasks"

def spec_files(dir)
  Dir[File.expand_path("../#{dir}/**/*_spec.rb", __FILE__)] * ' '
end

desc "Run all specs"
task :spec do
  system %(ruby #{spec_files('spec')})
end

desc "Run only proc specs"
task :'spec:proc' do
  system %(ruby #{spec_files('spec/proc')})
end

desc "Run only method specs"
task :'spec:method' do
  system %(ruby #{spec_files('spec/method')})
end
