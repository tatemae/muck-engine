require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the muck_users gem.'
Rake::TestTask.new(:spec) do |t|
  t.libs << 'lib'
  t.libs << 'test/rails_root/spec'
  t.pattern = 'test/rails_root/spec/**/*_spec.rb'
  t.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    #t.libs << 'lib'
    t.libs << 'test/rails_root/lib'
    t.pattern = 'test/rails_root/test/**/*_test.rb'
    t.verbose = true
    t.output_dir = 'coverage'
    t.rcov_opts << '--exclude "gems/*"'
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

desc 'Generate documentation for the muck_engine plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MuckEngine'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Translate this gem'
task :translate do
  file = File.join(File.dirname(__FILE__), 'locales', 'en.yml')
  system("babelphish -o -y #{file}")
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "muck-engine"
    gemspec.summary = "The base engine for the muck system."
    gemspec.email = "justin@tatemae.com"
    gemspec.homepage = "http://github.com/tatemae/muck_engine"
    gemspec.description = "The base engine for the muck system.  Contains common tables, custom for, css and javascript."
    gemspec.authors = ["Justin Ball", "Joel Duffin"]
    gemspec.rubyforge_project = 'muck-engine'
    gemspec.add_dependency "validation_reflection", ">=1.0.0.rc.1"  #TODO Be sure to update versions after they are released for Rails 3
    gemspec.add_dependency "will_paginate"
    gemspec.add_dependency "overlord"
    gemspec.add_development_dependency "shoulda"
    gemspec.add_development_dependency "rspec-rails", ">=2.0.0.beta.22"
    gemspec.add_development_dependency "cucumber-rails"
    gemspec.add_development_dependency "autotest"
    gemspec.add_development_dependency "capybara", ">= 0.3.9"
    gemspec.add_development_dependency "shoulda"
    gemspec.add_development_dependency "factory_girl"
    gemspec.add_development_dependency "cucumber"
    gemspec.add_development_dependency "rcov"
    gemspec.add_development_dependency "rspec", ">=2.0.0.beta.22"
    gemspec.add_development_dependency "database_cleaner"
    gemspec.add_development_dependency "spork"
    gemspec.add_development_dependency "launchy"
    gemspec.add_development_dependency "muck-users"
    gemspec.add_development_dependency "git"
  end
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
