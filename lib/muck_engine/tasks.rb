require 'rake'
require 'rake/tasklib'
require 'fileutils'
require 'jcode'
begin
  require 'git'
rescue LoadError
  puts "git gem not installed.  If git functionality for muck rake tasks is required run 'sudo gem install git'"
end

class MuckEngine
  class Tasks < ::Rake::TaskLib
    
    GREEN = "\033[0;32m"
    RED = "\033[0;31m"
    BLUE = "\033[0;34m"
    INVERT = "\033[00m"
    
    def initialize
      define
    end
  
    private
    def define
      
      namespace :muck do
      
        # just returns the names of the gems as specified by muck_gems
        def muck_gem_names
          if defined?(muck_gems)
            muck_gems
          else
            puts "Please create a method named 'muck_gems' in the namespace :muck in your rakefile."
          end
        end
      
        # Returns the folder name for each gem.  Note that muck-solr lives in the acts_as_solr directory
        def muck_gem_paths
          if defined?(muck_gems)
            muck_gems.collect{|name| muck_gem_path(name)}
          else
            puts "Please create a method named 'muck_gems' in the namespace :muck in your rakefile."
          end
        end

        def muck_gem_path(gem_name)
          if gem_name == 'muck-solr'
            'acts_as_solr'
          else
            gem_name
          end
        end

        def muck_gem_lib(gem_name)
          if gem_name == 'muck-solr'
            'acts_as_solr'
          else
            gem_name.sub('-', '_')
          end
        end
      
        def muck_unpack(gem_name)
          system("gem unpack #{gem_name} --target=#{muck_gems_path}")
        end

        def muck_write_specs
          Dir.glob("#{muck_gems_path}/*").each do |dir|
            if File.directory?(dir)
              muck_gem = muck_gems.detect{|muck_gem| dir.include?(muck_gem)}
              if muck_gem
                inside dir do
                  system("gem specification #{muck_gem} > .specification")
                end
              end
            end
          end 
        end

        def ensure_muck_gems_path
          gem_path = muck_gems_path
          FileUtils.mkdir_p(gem_path) unless File.exists?(gem_path)
        end

        def muck_gems_path
          #File.join(File.dirname(__FILE__), '..', '..', 'vendor', 'gems')
          File.join(RAILS_ROOT, 'vendor', 'gems')
        end

        # Path to all other projects.  Usually the muck engines will be a sibling to muck
        def projects_path
          File.join(RAILS_ROOT, '..')
        end
      
        def release_gem(path, gem_name)
          gem_path = File.join(path, muck_gem_path(gem_name))
          puts "releasing #{gem_name}"
          inside gem_path do
            if File.exists?('pkg/*')
              puts "attempting to delete files from pkg.  Results #{system("rm pkg/*")}"
            end
            puts system("rake version:bump:patch")
            system("rake gemspec")
            puts system("rake gemcutter:release")
          end
          write_new_gem_version(path, gem_name)
        end

        # examples of stuff we need to look for:
        # config.gem "muck-raker", :lib => 'muck_raker', :version => '>=0.3.2'
        def write_new_gem_version(path, gem_name)
          puts "Updating version for: #{gem_name}"
          gem_lib = muck_gem_lib(gem_name)
          gem_path = File.join(path, muck_gem_path(gem_name))
          env_file = File.join(RAILS_ROOT, 'config', 'environment.rb')
          version_file = File.join(gem_path, 'VERSION')
          if !File.exists?(version_file)
            puts "Could not find version file for #{gem_name}.  You probably don't have the code for this gem.  
              No big deal since if you don't have the code you probably haven't change it.  Skipping version for this gem."
            return 
          end
          version = IO.read(version_file).strip
          environment = IO.read(env_file)
        
          search = Regexp.new(/\:lib\s*=>\s*['"]#{gem_lib}['"],\s*\:version\s*=>\s*['"][ <>=~]*\d+\.\d+\.\d+['"]/)
          failure = environment.gsub!(search, ":lib => '#{gem_lib}', :version => '>=#{version}'").nil?
        
          if failure
            search = Regexp.new(/config.gem\s*['"]#{gem_name}['"],\s*\:version\s*=>\s*['"][ <>=~]*\d+\.\d+\.\d+['"]/)
            failure = environment.gsub!(search, "config.gem '#{gem_name}', :version => '>=#{version}'").nil?
          end  

          if failure
            search = Regexp.new(/config.gem\s*['"]#{gem_name}['"],\s*\:lib\s*=>\s*['"]#{gem_lib}['"]/)
            failure = environment.gsub!(search, "config.gem '#{gem_name}', :lib => '#{gem_lib}', :version => '>=#{version}'").nil?
          end
        
          if failure
            search = Regexp.new(/config.gem\s*['"]#{gem_name}['"]/)
            failure = environment.gsub!(search, "config.gem '#{gem_name}', :version => '>=#{version}'").nil?
          end
        
          if failure
            puts "Could not update version for #{gem_name}"
          end

          File.open(env_file, 'w') { |f| f.write(environment) }
        end

        def git_commit(path, message)
          puts "Commiting #{BLUE}#{File.basename(path)}#{INVERT}"
          repo = Git.open("#{path}")
          puts repo.add('.')
          puts repo.commit(message) rescue 'nothing to commit'
        end

        def git_push(path)
          puts "Pushing #{BLUE}#{File.basename(path)}#{INVERT}"
          repo = Git.open("#{path}")
          puts repo.push
        end

        def git_pull(path)
          puts "Pulling code for #{BLUE}#{File.basename(path)}#{INVERT}"
          repo = Git.open("#{path}")
          puts repo.pull
        end

        def git_status(path)
          repo = Git.open("#{path}")
          status = repo.status

          changed = (status.changed.length > 0 ? RED : GREEN) + "#{status.changed.length}#{INVERT}"
          untracked = (status.untracked.length > 0 ? RED : GREEN) + "#{status.untracked.length}#{INVERT}"
          added = (status.added.length > 0 ? RED : GREEN) + "#{status.added.length}#{INVERT}"
          deleted = (status.deleted.length > 0 ? RED : GREEN) + "#{status.deleted.length}#{INVERT}"
          puts "#{BLUE}#{File.basename(path)}:#{INVERT}  Changed(#{changed}) Untracked(#{untracked}) Added(#{added}) Deleted(#{deleted})"
          if status.changed.length > 0
            status.changed.each do |file|
              puts "    Changed: #{RED}#{file[1].path}#{INVERT}"
            end
          end
          # if status.untracked.length > 0
          #   status.untracked.each do |file|
          #     puts "    Untracked: #{RED}#{file[1].path}#{INVERT}"
          #   end
          # end
          # if status.added.length > 0
          #   status.added.each do |file|
          #     puts "    Added: #{RED}#{file[1].path}#{INVERT}"
          #   end
          # end
          if status.deleted.length > 0
            status.deleted.each do |file|
              puts "    Deleted: #{RED}#{file[1].path}#{INVERT}"
            end
          end
          puts ""
        end

        # execute commands in a different directory
        def inside(dir, &block)
          FileUtils.cd(dir) { block.arity == 1 ? yield(dir) : yield }
        end
        
        namespace :gems do
          
          desc "Release and commit muck gems"
          task :release_commit do
            muck_gem_names.each do |gem_name|
              message = "Released new gem"
              release_gem("#{projects_path}", gem_name)
              git_commit("#{projects_path}/#{muck_gem_path(gem_name)}", message)
              git_push("#{projects_path}/#{muck_gem_path(gem_name)}")
            end
          end

          desc "Release muck gems"
          task :release do
            muck_gem_names.each do |gem_name|
              release_gem("#{projects_path}", gem_name)
            end
          end

          desc "commit gems after a release"
          task :commit do
            message = "Released new gem"
            muck_gem_paths.each do |gem_name|
              git_commit("#{projects_path}/#{gem_name}", message)
            end
          end

          desc "Pull code for all the gems (use with caution)"
          task :pull do
            muck_gem_paths.each do |gem_name|
              git_pull("#{projects_path}/#{gem_name}")
            end
          end

          desc "Push code for all the gems (use with caution)"
          task :push do
            muck_gem_paths.each do |gem_name|
              git_push("#{projects_path}/#{gem_name}")
            end
          end

          desc "Gets status for all the muck gems"
          task :status do
            muck_gem_paths.each do |gem_name|
              git_status("#{projects_path}/#{gem_name}")
            end
          end
        
          desc "Test all muck gems"
          task :test do
            muck_gem_paths.each do |gem_name|
              puts "***************************************************************"
              puts "testing #{gem_name}"
              puts "***************************************************************"
              system("cd #{projects_path}/#{gem_name}/ && rake test")
            end
          end

          desc "Translate all muck gems"
          task :translate do
            muck_gem_paths.each do |gem_name|
              puts "translating #{gem_name}"
              system("babelphish -o -y #{projects_path}/#{gem_name}/locales/en.yml")
            end
          end

          desc "Unpacks all muck gems into vendor/gems using versions installed on the local machine."
          task :unpack do
            ensure_muck_gems_path
            muck_gems.each do |gem_name|
              muck_unpack(gem_name)
            end
            muck_write_specs
          end
          
          desc "Install and unpacks all muck gems into vendor/gems."
          task :unpack_install => :install do
            ensure_muck_gems_path
            muck_gems.each do |gem_name|
              muck_unpack(gem_name)
            end
            muck_write_specs
          end

          desc "Install all the gems specified in muck_gems"
          task :install do
            muck_gems.each do |gem_name|
              system("sudo gem install #{gem_name}")
            end
          end
          
          desc "write specs into muck gems"
          task :specs do
            muck_write_specs
          end
          
        end
        
        
        desc "Write muck gem versions into muck"
        task :versions do
          muck_gem_names.each do |gem_name|
            write_new_gem_version("#{projects_path}", gem_name)
          end
        end

        desc 'Translate app into all languages supported by Google'
        task :translate_app => :environment do
          puts 'translating app'
          system("babelphish -o -y #{RAILS_ROOT}/config/locales/en.yml")
        end

        desc "Completely reset and repopulate the database and annotate models. THIS WILL DELETE ALL YOUR DATA"
        task :reset do
          Rake::Task[ "muck:sync" ].execute
          Rake::Task[ "muck:reset_db" ].execute
        end
        
        desc "Sync resources from all muck related gems."
        task :sync do
          puts 'syncronizing engines and gems'
          muck_gems.each do |gem_name|
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
            Muck::Populate.all
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
    
    end
  end
end

MuckEngine::Tasks.new