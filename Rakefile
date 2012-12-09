require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

namespace :cucumber do
  Cucumber::Rake::Task.new(:ok,  'Run features that should pass') do |t|
    t.cucumber_opts = ['--strict', '--tags ~@wip', '--format progress']
  end

  Cucumber::Rake::Task.new(:wip, 'Run features that are being worked on') do |t|
    t.cucumber_opts = ['--wip', '--tags @wip']
  end

  Cucumber::Rake::Task.new(:all, 'Run all features')
end

namespace :rspec do
  desc 'Run specs with progress output'
  RSpec::Core::RakeTask.new(:progress) do |t|
    t.rspec_opts = '--format progress'
  end

  desc 'Run all specs'
  RSpec::Core::RakeTask.new(:spec)
end

task spec:     'rspec:spec'
task cucumber: 'cucumber:ok'
task test:     ['rspec:progress', 'cucumber:ok']
task default:  'test'
