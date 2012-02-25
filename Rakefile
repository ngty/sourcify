require "bundler/gem_tasks"

desc "Run all specs"
task :spec do
  system %(testrb spec/*/*_spec.rb)
end

desc "Run only proc specs"
task :'spec:proc' do
  system %(testrb spec/proc/*/*_spec.rb)
end

desc "Run only method specs"
task :'spec:method' do
  system %(testrb spec/method/*/*_spec.rb)
end
