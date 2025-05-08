require "minitest/test_task"

Minitest::TestTask.create(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.warning = false
  t.test_globs = ["test/**/*_test.rb"]
end

task :default => :test

task :worker do
  sh "bin/worker"
end

task :server do
  sh "rackup server/config.ru -p 3000 -o 0.0.0.0"
end

