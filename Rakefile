require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Default: run specs.'
task :default => :spec
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['test/rails_test/spec/**/*_spec.rb']
end

desc 'Test the muck-users gem.'
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

desc 'Generate documentation for the muck-engine plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MuckEngine'
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
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "muck-engine"
    gemspec.summary = "The base engine for the muck system."
    gemspec.email = "justin@tatemae.com"
    gemspec.homepage = "http://github.com/tatemae/muck_engine"
    gemspec.description = "The base engine for the muck system.  Contains common tables, custom for, css and javascript."
    gemspec.authors = ["Justin Ball", "Joel Duffin"]
    gemspec.rubyforge_project = 'muck-engine'
    gemspec.add_dependency "validation_reflection"
    gemspec.add_dependency "will_paginate", '~> 3.0.beta'
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
