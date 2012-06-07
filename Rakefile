#!/usr/bin/env rake

require "bundler/gem_tasks"

require File.expand_path(File.dirname(__FILE__) + '/lib/meta_methods/version')

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.verbose = false
end

desc "Release the gem"
task :"release:gem" do
  %x(
rake build
rake install
git add .
)
  puts "Commit message:"
  message = STDIN.gets

  %x(
git commit -m "#{message}"
git push origin master

gem push pkg/#{File.basename(Dir.pwd)}-#{MetaMethods::VERSION}.gem
)
end

