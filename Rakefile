#!/usr/bin/env rake

$LOAD_PATH.unshift File.expand_path("lib", File.dirname(__FILE__))

require "rspec/core/rake_task"
require "meta_methods/version"
require "gemspec_deps_gen/gemspec_deps_gen"

version = MetaMethods::VERSION
project_name = File.basename(Dir.pwd)

task :gen do
  generator = GemspecDepsGen.new

  generator.generate_dependencies "spec", "#{project_name}.gemspec.erb", "#{project_name}.gemspec"
end

task :build => :gen do
  system "gem build #{project_name}.gemspec"
end

task :install do
  system "gem install #{project_name}-#{version}.gem"
end

task :uninstall do
  system "gem uninstall #{project_name}"
end

task :release => :build do
  system "gem push #{project_name}-#{version}.gem"
end

RSpec::Core::RakeTask.new do |task|
  task.pattern = 'spec/**/*_spec.rb'
  task.verbose = false
end

# task :fix_debug do
#   system "mkdir -p $GEM_HOME/gems/debugger-ruby_core_source-1.2.3/lib"
#   system "cp -R ~/debugger-ruby_core_source/lib $GEM_HOME/gems/debugger-ruby_core_source-1.2.3"
# end

