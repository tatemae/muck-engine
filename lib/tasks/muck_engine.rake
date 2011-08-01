require 'fileutils'

if RUBY_VERSION < '1.9'
  begin
    require 'jcode'
  rescue LoadError
    begin
      gem 'jcode'
    rescue Gem::LoadError
      puts "Please install the jcode gem"
    end
  end  
end

require 'rubygems'

require 'muck-engine/populate'

GREEN = "\033[0;32m"
RED = "\033[0;31m"
BLUE = "\033[0;34m"
INVERT = "\033[00m"    
      
namespace :muck do

  # just returns the names of the gems as specified by muck_gems
  def muck_gem_names
    muck_gems = []
    Rails.application.railties.all.each do |railtie|
      muck_gems << railtie.muck_name if railtie.respond_to?(:muck_name)
    end    
    muck_gems
  end
  
  desc "Sync resources from all muck related gems."
  task :sync do
    puts 'syncronizing engines and gems'
    muck_gem_names.each do |gem_name|
      puts "syncronizing assets and code from #{gem_name}"
      if gem_name.include?('muck')
        task = "muck:sync:#{gem_name.gsub('muck-', '')}"
      else
        task = "#{gem_name}:sync"
      end
      begin
        puts "Syncing: #{gem_name}"
        Rake::Task[ task ].execute
      rescue
        puts "could not find task: #{task}"
      end
    end
  end

  namespace :sync do
    desc "Sync files from muck engine."
    task :engine do
      path = File.join(File.dirname(__FILE__), *%w[.. ..])
      # FileUtils.cp_r "#{path}/db", ".", :verbose => true, :remove_destination => true
      # FileUtils.cp_r "#{path}/public", ".", :verbose => true, :remove_destination => true
      system "rsync -ruv #{path}/db ."
      system "rsync -ruv #{path}/public ."
    end
  end

  namespace :db do
    desc "populate database with language, state and country data"
    task :populate => :environment do
      MuckEngine::Populate.all
      puts 'Finished adding languages, countries and states'
    end
    
    desc "Drop, creates, migrations and populates the database"
    task :reset => :environment do

      puts 'droping databases'
      Rake::Task[ "db:drop" ].execute

      puts 'creating databases'
      Rake::Task[ "db:create" ].execute

      puts 'migrating'
      Rake::Task[ "db:migrate" ].execute

      Rake::Task[ "db:setup_db" ].execute
    end

    desc "populates the database with all required values"
    task :setup => :environment do
      puts 'populating db with locale info'
      Rake::Task[ "muck:db:populate" ].execute

      puts 'flagging the languages muck raker supports and adding services it supports'
      Rake::Task[ "muck:raker:db:populate" ].execute

      puts 'adding some oai endpoints and feeds to the db'
      Rake::Task[ "muck:raker:db:bootstrap" ].execute

      puts 'setting up admin account'
      Rake::Task[ "muck:users:create_admin" ].execute
    end
  end
end
