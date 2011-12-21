require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["--color", "-c", "-f progress", "-r test/spec/spec_helper.rb"]
  t.pattern = 'test/spec/**/*_spec.rb'
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.libs << 'test/lib'
    t.pattern = 'test/test/**/*_spec.rb'
    t.verbose = true
    t.output_dir = 'coverage'
    t.rcov_opts << '--exclude "gems/*"'
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

require 'rake/rdoctask'
desc 'Generate documentation for the muck-engine plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "muck-engine #{version}"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Translate this gem'
task :translate do
  file = File.join(File.dirname(__FILE__), 'config', 'locales', 'en.yml')
  system("babelphish -o -y #{file}")
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "muck-engine"
    gem.summary = "The base engine for the muck system."
    gem.email = "justin@tatemae.com"
    gem.homepage = "http://github.com/tatemae/muck-engine"
    gem.description = "The base engine for the muck system.  Contains common tables, custom for, css and javascript."
    gem.authors = ["Justin Ball", "Joel Duffin"]
    gem.add_dependency "validation_reflection"
    gem.add_dependency "will_paginate", "~> 3.0.0"
    gem.add_dependency "overlord"
    gem.add_development_dependency "shoulda"
    gem.add_development_dependency "rspec-rails"
    gem.add_development_dependency "cucumber-rails"
    gem.add_development_dependency "autotest"
    gem.add_development_dependency "capybara"
    gem.add_development_dependency "shoulda"
    gem.add_development_dependency "factory_girl"
    gem.add_development_dependency "cucumber"
    gem.add_development_dependency "rcov"
    gem.add_development_dependency "rspec"
    gem.add_development_dependency "database_cleaner"
    gem.add_development_dependency "spork"
    gem.add_development_dependency "launchy"
    gem.add_development_dependency "muck-users"
    gem.add_development_dependency "git"
    gem.files.exclude "public/images/service_icons/source/*"
    gem.files.exclude 'test/**'
  end
  Jeweler::RubygemsDotOrgTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
