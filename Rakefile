require "bundler/gem_tasks"

desc "Run all specs"
task :spec do
  system %(ruby spec/*/*_spec.rb)
end

desc "Run only proc specs"
task :'spec:proc' do
  system %(ruby spec/proc/*_spec.rb)
end

desc "Run only method specs"
task :'spec:method' do
  system %(ruby spec/method/*_spec.rb)
end
