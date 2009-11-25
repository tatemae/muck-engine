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
        
        desc "Release and commit muck gems"
        task :release_commit_gems do
          muck_gem_names.each do |gem_name|
            message = "Released new gem"
            release_gem("#{projects_path}", gem_name)
            git_commit("#{projects_path}/#{muck_gem_path(gem_name)}", message)
            git_push("#{projects_path}/#{muck_gem_path(gem_name)}")
          end
        end

        desc "Release muck gems"
        task :release_gems do
          muck_gem_names.each do |gem_name|
            release_gem("#{projects_path}", gem_name)
          end
        end

        desc "commit gems after a release"
        task :commit_gems do
          message = "Released new gem"
          muck_gem_paths.each do |gem_name|
            git_commit("#{projects_path}/#{gem_name}", message)
          end
        end

        desc "Pull code for all the gems (use with caution)"
        task :pull_gems do
          muck_gem_paths.each do |gem_name|
            git_pull("#{projects_path}/#{gem_name}")
          end
        end

        desc "Push code for all the gems (use with caution)"
        task :push_gems do
          muck_gem_paths.each do |gem_name|
            git_push("#{projects_path}/#{gem_name}")
          end
        end

        desc "Gets status for all the muck gems"
        task :status_gems do
          muck_gem_paths.each do |gem_name|
            git_status("#{projects_path}/#{gem_name}")
          end
        end
        
        desc "Write muck gem versions into muck"
        task :versions do
          muck_gem_names.each do |gem_name|
            write_new_gem_version("#{projects_path}", gem_name)
          end
        end
        
        desc "Translate all muck gems"
        task :translate_gems do
          muck_gem_paths.each do |gem_name|
            puts "translating #{gem_name}"
            system("babelphish -o -y #{projects_path}/#{gem_name}/locales/en.yml")
          end
        end
        
        desc 'Translate app into all languages supported by Google'
        task :translate_app => :environment do
          puts 'translating app'
          system("babelphish -o -y #{RAILS_ROOT}/config/locales/en.yml")
        end
        
        desc "write specs into muck gems"
        task :specs do
          muck_write_specs
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
        task :unpack_install => :install_gems do
          ensure_muck_gems_path
          muck_gems.each do |gem_name|
            muck_unpack(gem_name)
          end
          muck_write_specs
        end
        
        desc "Install all the gems specified in muck_gems"
        task :install_gems do
          muck_gems.each do |gem_name|
            system("sudo gem install #{gem_name}")
          end
        end

        task :setup do
          Rake::Task[ "cms_lite:setup" ].execute if muck_gems.include?('cms-lite')
          Rake::Task[ "disguise:setup" ].execute if muck_gems.include?('disguise')
        end

        desc "Sync resources from all muck related gems."
        task :sync do
          puts 'syncronizing engines and gems'
          muck_gems.each do |gem_name|
            puts "syncronizing assets and code from #{gem_name}"
            if gem_name.include?('muck')
              task = "muck:#{gem_name.gsub('muck-', '')}:sync"
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

        desc "Completely reset and repopulate the database and annotate models. THIS WILL DELETE ALL YOUR DATA"
        task :reset do
          Rake::Task[ "muck:sync" ].execute
          Rake::Task[ "muck:reset_db" ].execute
        end

        desc "Drop, creates, migrations and populates the database"
        task :reset_db => :environment do

          puts 'droping databases'
          Rake::Task[ "db:drop" ].execute

          puts 'creating databases'
          Rake::Task[ "db:create" ].execute

          puts 'migrating'
          Rake::Task[ "db:migrate" ].execute

          Rake::Task[ "db:setup_db" ].execute
        end

        desc "populates the database with all required values"
        task :setup_db => :environment do
          puts 'populating db with locale info'
          Rake::Task[ "muck:db:populate" ].execute

          puts 'flagging the languages muck raker supports and adding services it supports'
          Rake::Task[ "muck:raker:db:populate" ].execute

          puts 'adding some oai endpoints and feeds to the db'
          Rake::Task[ "muck:raker:db:bootstrap" ].execute

          puts 'setting up admin account'
          Rake::Task[ "muck:users:create_admin" ].execute
        end
        
        
        namespace :engine do
          desc "Sync files from muck engine."
          task :sync do
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
            $KCODE = 'UTF8'
            [
              ['AD', 'Andorra'],
              ['AE', 'United Arab Emirates'],
              ['AF', 'Afghanistan'],
              ['AG', 'Antigua and Barbuda'],
              ['AI', 'Anguilla'],
              ['AL', 'Albania'],
              ['AM', 'Armenia'],
              ['AN', 'Netherlands Antilles'],
              ['AO', 'Angola'],
              ['AQ', 'Antarctica'],
              ['AR', 'Argentina'],
              ['AS', 'American Samoa'],
              ['AU', 'Austria'],
              ['AS', 'Australia'],
              ['AW', 'Aruba'],
              ['AZ', 'Azerbaijan'],
              ['BA', 'Bosnia and Herzegovina'],
              ['BB', 'Barbados'],
              ['BD', 'Bangladesh'],
              ['BE', 'Belgium'],
              ['BF', 'Burkina Faso'],
              ['BH', 'Bahrain'],
              ['BI', 'Burundi'],
              ['BJ', 'Benin'],
              ['BM', 'Bermuda'],
              ['BO', 'Bolivia'],
              ['BR', 'Brazil'],
              ['BS', 'Bahamas'],
              ['BT', 'Bhutan'],
              ['BU', 'Bouvet Island'],
              ['BV', 'Bulgaria'],
              ['BW', 'Botswana'],
              ['BX', 'Brunei Darussalam'],
              ['BY', 'Belarus'],
              ['BZ', 'Belize'],
              ['CA', 'Canada', 2],
              ['CC', 'Cocos (Keeling) Islands'],
              ['CF', 'Central African Republic'],
              ['CG', 'Congo'],
              ['CH', 'Switzerland'],
              ['CI', 'Cote D\'Ivoire (Ivory Coast)'],
              ['CK', 'Cook Islands'],
              ['CL', 'Chile'],
              ['CM', 'Cameroon'],
              ['CN', 'China'],
              ['CO', 'Colombia'],
              ['CR', 'Costa Rica'],
              ['CU', 'Cuba'],
              ['CV', 'Cape Verde'],
              ['CX', 'Christmas Island'],
              ['CY', 'Cyprus'],
              ['CZ', 'Czech Republic'],
              ['DE', 'Germany'],
              ['DJ', 'Djibouti'],
              ['DK', 'Denmark'],
              ['DM', 'Dominica'],
              ['DO', 'Dominican Republic'],
              ['DZ', 'Algeria'],
              ['EC', 'Ecuador'],
              ['EE', 'Estonia'],
              ['EG', 'Egypt'],
              ['EH', 'Western Sahara'],
              ['ER', 'Eritrea'],
              ['ES', 'Spain'],
              ['ET', 'Ethiopia'],
              ['FI', 'Finland'],
              ['FJ', 'Fiji'],
              ['FK', 'Falkland Islands (Malvinas)'],
              ['FM', 'Micronesia'],
              ['FO', 'Faroe Islands'],
              ['FR', 'France'],
              ['GA', 'Gabon'],
              ['GB', 'Great Britain (UK)'],
              ['GD', 'Grenada'],
              ['GE', 'Georgia'],
              ['GF', 'French Guiana'],
              ['GH', 'Ghana'],
              ['GI', 'Gibraltar'],
              ['GL', 'Greenland'],
              ['GM', 'Gambia'],
              ['GN', 'Guinea'],
              ['GP', 'Guadeloupe'],
              ['GQ', 'Equatorial Guinea'],
              ['GR', 'Greece'],
              ['GS', 'South Georgia and South Sandwich Islands'],
              ['GT', 'Guatemala'],
              ['GU', 'Guam'],
              ['GW', 'Guinea-Bissau'],
              ['GY', 'Guyana'],
              ['HK', 'Hong Kong'],
              ['HM', 'Heard and McDonald Islands'],
              ['HN', 'Honduras'],
              ['HR', 'Croatia and Hrvatska'],
              ['HT', 'Haiti'],
              ['HU', 'Hungary'],
              ['ID', 'Indonesia'],
              ['IE', 'Ireland'],
              ['IL', 'Israel'],
              ['IN', 'India'],
              ['IO', 'British Indian Ocean Territory'],
              ['IQ', 'Iraq'],
              ['IR', 'Iran'],
              ['IS', 'Iceland'],
              ['IT', 'Italy'],
              ['JM', 'Jamaica'],
              ['JO', 'Jordan'],
              ['JP', 'Japan'],
              ['KE', 'Kenya'],
              ['KG', 'Kyrgyzstan'],
              ['KH', 'Cambodia'],
              ['KI', 'Kiribati'],
              ['KM', 'Comoros'],
              ['KN', 'Saint Kitts and Nevis'],
              ['KP', 'Korea North'],
              ['KR', 'Korea South'],
              ['KW', 'Kuwait'],
              ['KY', 'Cayman Islands'],
              ['KZ', 'Kazakhstan'],
              ['LA', 'Laos'],
              ['LB', 'Lebanon'],
              ['LC', 'Saint Lucia'],
              ['LI', 'Liechtenstein'],
              ['LK', 'Sri Lanka'],
              ['LR', 'Liberia'],
              ['LS', 'Lesotho'],
              ['LT', 'Lithuania'],
              ['LU', 'Luxembourg'],
              ['LV', 'Latvia'],
              ['LY', 'Libya'],
              ['MA', 'Morocco'],
              ['MC', 'Monaco'],
              ['MD', 'Moldova'],
              ['MG', 'Madagascar'],
              ['MH', 'Marshall Islands'],
              ['MK', 'Macedonia'],
              ['ML', 'Mali'],
              ['MM', 'Myanmar'],
              ['MN', 'Mongolia'],
              ['MO', 'Macau'],
              ['MP', 'Northern Mariana Islands'],
              ['MQ', 'Martinique'],
              ['MR', 'Mauritania'],
              ['MS', 'Montserrat'],
              ['MT', 'Malta'],
              ['MU', 'Mauritius'],
              ['MV', 'Maldives'],
              ['MW', 'Malawi'],
              ['MX', 'Mexico'],
              ['MY', 'Malaysia'],
              ['MZ', 'Mozambique'],
              ['NA', 'Namibia'],
              ['NC', 'New Caledonia'],
              ['NE', 'Niger'],
              ['NF', 'Norfolk Island'],
              ['NG', 'Nigeria'],
              ['NI', 'Nicaragua'],
              ['NE', 'Netherlands'],
              ['NO', 'Norway'],
              ['NP', 'Nepal'],
              ['NR', 'Nauru'],
              ['NU', 'Niue'],
              ['NZ', 'New Zealand'],
              ['OM', 'Oman'],
              ['PA', 'Panama'],
              ['PE', 'Peru'],
              ['PF', 'French Polynesia'],
              ['PG', 'Papua New Guinea'],
              ['PH', 'Philippines'],
              ['PK', 'Pakistan'],
              ['PO', 'Poland'],
              ['PM', 'St. Pierre and Miquelon'],
              ['PN', 'Pitcairn'],
              ['PR', 'Puerto Rico'],
              ['PT', 'Portugal'],
              ['PW', 'Palau'],
              ['PY', 'Paraguay'],
              ['QA', 'Qatar'],
              ['RE', 'Reunion'],
              ['RO', 'Romania'],
              ['RU', 'Russian Federation'],
              ['RW', 'Rwanda'],
              ['SA', 'Saudi Arabia'],
              ['SB', 'Solomon Islands'],
              ['SC', 'Seychelles'],
              ['SD', 'Sudan'],
              ['SE', 'Sweden'],
              ['SG', 'Singapore'],
              ['SH', 'St. Helena'],
              ['SI', 'Slovenia'],
              ['SJ', 'Svalbard and Jan Mayen Islands'],
              ['SK', 'Slovak Republic'],
              ['SL', 'Sierra Leone'],
              ['SM', 'San Marino'],
              ['SN', 'Senegal'],
              ['SO', 'Somalia'],
              ['SR', 'Suriname'],
              ['ST', 'Sao Tome and Principe'],
              ['SV', 'El Salvador'],
              ['SY', 'Syria'],
              ['SZ', 'Swaziland'],
              ['TC', 'Turks and Caicos Islands'],
              ['TD', 'Chad'],
              ['TF', 'French Southern Territories'],
              ['TG', 'Togo'],
              ['TH', 'Thailand'],
              ['TI', 'Tajikistan'],
              ['TK', 'Tokelau'],
              ['TM', 'Turkmenistan'],
              ['TN', 'Tunisia'],
              ['TO', 'Tonga'],
              ['TP', 'East Timor'],
              ['TR', 'Turkey'],
              ['TT', 'Trinidad and Tobago'],
              ['TV', 'Tuvalu'],
              ['TW', 'Tahean'],
              ['TZ', 'Tanzania'],
              ['UA', 'Ukraine'],
              ['UG', 'Uganda'],
              ['UK', 'United Kingdom', 3],
              ['UM', 'US Minor Outlying Islands'],
              ['US', 'United States of America (USA)', 1],
              ['UY', 'Uruguay'],
              ['UZ', 'Uzbekistan'],
              ['VA', 'Vatican City State'],
              ['VC', 'Saint Vincent and the Grenadines'],
              ['VE', 'Venezuela'],
              ['VG', 'Virgin Islands (British)'],
              ['VN', 'Viet Nam'],
              ['VU', 'Vanuatu'],
              ['WF', 'Wallis and Futuna Islands'],
              ['WS', 'Samoa'],
              ['YE', 'Yemen'],
              ['YT', 'Mayotte'],
              ['YU', 'Yugoslavia'],
              ['ZA', 'South Africa'],
              ['ZM', 'Zambia'],
              ['ZR', 'Zaire'],
              ['ZW', 'Zimbabwe']
            ].each {|c| Country.create(:abbreviation => c[0], :name => c[1], :sort => (c.length >= 3 ? c[2] : 1000 ))  unless Country.find_by_name(c[1]) }

            us_id = Country.find_by_abbreviation('US').id

            [
              ['Alaska', 'AK', us_id],
              ['Alabama', 'AL', us_id],
            #       ['AMERICAN SAMOA', 'AS', us_id],
              ['Arkansas', 'AR', us_id],
              ['Arizona', 'AZ', us_id],
              ['California', 'CA', us_id],
              ['Colorado', 'CO', us_id],
              ['Connecticut', 'CT', us_id],
              ['District of Columbia', 'DC', us_id],
              ['Washington, DC', 'DC', us_id],
              ['Delaware', 'DE', us_id],
              ['Florida', 'FL', us_id],
            #        ['FEDERATED STATES OF MICRONESIA', 'FM', us_id],
              ['Georgia', 'GA', us_id],
            #        ['GUAM', 'GU', us_id],
              ['Hawaii', 'HI', us_id],
              ['Iowa', 'IA', us_id],
              ['Idaho', 'ID', us_id],
              ['Illinois', 'IL', us_id],
              ['Indiana', 'IN', us_id],
              ['Kansas', 'KS', us_id],
              ['Kentucky', 'KY', us_id],
              ['Louisiana', 'LA', us_id],
              ['Massachusetts', 'MA', us_id],
              ['Maryland', 'MD', us_id],
              ['Maine', 'ME', us_id],
            #        ['MARSHALL ISLANDS', 'MH', us_id],
              ['Michigan', 'MI', us_id],
              ['Minnesota', 'MN', us_id],
              ['Missouri', 'MO', us_id],
            #        ['NORTHERN MARIANA ISLANDS', 'MP', us_id],
              ['Mississippi', 'MS', us_id],
              ['Montana', 'MT', us_id],
              ['North Carolina', 'NC', us_id],
              ['North Dakota', 'ND', us_id],
              ['Nebraska', 'NE', us_id],
              ['New Hampshire', 'NH', us_id],
              ['New Jersey', 'NJ', us_id],
              ['New Mexico', 'NM', us_id],
              ['Nevada', 'NV', us_id],
              ['New York', 'NY', us_id],
              ['Ohio', 'OH', us_id],
              ['Oklahoma', 'OK', us_id],
              ['Oregon', 'OR', us_id],
              ['Pennsylvania', 'PA', us_id],
              ['Puerto Rico', 'PR', us_id],
            #        ['PALAU', 'PW', us_id],
              ['Rhode Island', 'RI', us_id],
              ['South Carolina', 'SC', us_id],
              ['South Dakota', 'SD', us_id],
              ['Tennessee', 'TN', us_id],
              ['Texas', 'TX', us_id],
              ['Utah', 'UT', us_id],
              ['Virginia', 'VA', us_id],
            #        ['VIRGIN ISLANDS', 'VI', us_id],
              ['Vermont', 'VT', us_id],
              ['Washington', 'WA', us_id],
              ['Wisconsin', 'WI', us_id],
              ['West Virginia', 'WV', us_id],
              ['Wyoming', 'WY', us_id]
            ].each {|s| State.create(:name => s[0], :abbreviation => s[1], :country_id => s[2]) unless State.find_by_name(s[0]) }

            # The UK
            ireland_id = Country.find_by_abbreviation('IE').id
            #northern_ireland_id = Country.find_by_abbreviation('NIR').id
            scotland_id = Country.find_by_abbreviation('SCT').id
            england_id = Country.find_by_abbreviation('ENG').id
            wales_id = Country.find_by_abbreviation('WAL').id
            #channel_islands_id = Country.find_by_abbreviation('CHI').id
            [
              # Scotland
              #['Aberdeen', 'ABD', scotland_id],
              ['Aberdeenshire', 'ABD', scotland_id],
              ['Angus (Forfarshire)', 'ANS', scotland_id],
              #['Argyllshire', 'ARL', scotland_id],
              ['Argyll', '', scotland_id],
              #['Argyll and Bute', 'BUT', scotland_id],
              ['Ayrshire', 'AYR', scotland_id],
              ['Banffshire', 'BAN', scotland_id],
              ['Berwickshire', 'BEW', scotland_id],
              #['Borders', 'BOR', scotland_id],
              ['Bute', 'BUT', scotland_id],
              ['Caithness', 'CAI', scotland_id],
              #['Central', 'CEN', scotland_id],
              ['Clackmannanshire', 'CLK', scotland_id],
              ['Dumfries-shire', 'DFS', scotland_id],
              #['Dumfries and Galloway', 'DGY', scotland_id],
              ['Dunbartonshire', 'DNB', scotland_id],
              #['Dundee', '', scotland_id],
              #['East Ayrshire', '', scotland_id],
              #['East Dunbartonshire', '', scotland_id],
              ['East Lothian', 'ELN', scotland_id],
              #['East Renfrewshire', '', scotland_id],
              #['Edinburgh', '', scotland_id],
              #['Falkirk', '', scotland_id],
              ['Fife', 'FIF', scotland_id],
              #['Glasgow', '', scotland_id],
              #['Grampian', 'GMP', scotland_id],
              #['Highland', 'HLD', scotland_id],
              ['Inverness-shire', 'INV', scotland_id],
              ['Inverclyde', '', scotland_id],
              ['Kincardineshire', 'KCD', scotland_id],
              ['Kirkcudbrightshire', 'KKD', scotland_id],
              ['Kinross-shire', 'KRS', scotland_id],
              ['Lanarkshire (Glasgow)', 'LKS', scotland_id],
              #['Lothian', 'LTN', scotland_id],
              ['Midlothian (Edinburgh)', 'MLN', scotland_id],
              ['Moray', '', scotland_id],
              #['Morayshire', 'MOR', scotland_id],
              #['North Ayrshire', '', scotland_id],
              #['North Lanarkshire', '', scotland_id],
              #['Nairn', 'NAI', scotland_id],
              ['Nairnshire', 'NAI', scotland_id],
              ['Orkney', 'OKI', scotland_id],
              ['Peeblesshire', 'PEE', scotland_id],
              ['Perthshire', 'PER', scotland_id],
              #['Perth and Kinross', '', scotland_id],
              ['Renfrewshire', 'RFW', scotland_id],
              ['Ross and Cromarty', 'ROC', scotland_id],
              ['Roxburghshire', 'ROX', scotland_id],
              #['Scottish Borders', '', scotland_id],
              ['Selkirkshire', 'SEL', scotland_id],
              ['Shetland', 'SHI', scotland_id],
              #['South Ayrshire', '', scotland_id],
              #['South Lanarkshire', '', scotland_id],
              #['Strathclyde', 'STD', scotland_id],
              #['Stirling', 'STI', scotland_id],
              ['Stirlingshire', 'STI', scotland_id],
              ['Sutherland', 'SUT', scotland_id],
              #['Tayside', 'TAY', scotland_id],
              #['Wigtownshire', 'WIG', scotland_id],
              ['Western Isles', 'WIS', scotland_id],
              #['West Dunbartonshire', '', scotland_id],
              ['West Lothian', 'WLN', scotland_id],
              ['Wigtownshire', '', scotland_id],

              # Wales
              #['Anglesey', 'AGY', wales_id],
              #['Breconshire', 'BRE', wales_id],
              #['Caernarvonshire', 'CAE', wales_id],
              #['Cardiganshire', 'CGN', wales_id],
              #['Carmarthenshire', 'CMN', wales_id],
              ['Clwyd', 'CWD', wales_id],
              #['Denbighshire', 'DEN', wales_id],
              ['Dyfed', 'DFD', wales_id],
              #['Flintshire', 'FLN', wales_id],
              #['Glamorgan', 'GLA', wales_id],
              ['Gwent', 'GNT', wales_id],
              ['Gwynedd', 'GWN', wales_id],
              #['Merionethshire', 'MER', wales_id],
              ['Mid Glamorgan', 'MGM', wales_id],
              #['Montgomeryshire', 'MGY', wales_id],
              #['Monmouthshire', 'MON', wales_id],
              #['Pembrokeshire', 'PEM', wales_id],
              ['Powys', 'POW', wales_id],
              #['Radnorshire', 'RAD', wales_id],
              ['South Glamorgan', 'SGM', wales_id],
              ['West Glamorgan', 'WGM', wales_id],

              # Channel Islands
              # ['Alderney', 'ALD', channel_islands_id],
              # ['Guernsey', 'GSY', channel_islands_id],
              # ['Jersey', 'JSY', channel_islands_id],
              # ['Sark', 'SRK', channel_islands_id],

              # England
              #['Avon', 'AVN', england_id],
              ['Bedfordshire', 'BDF', england_id],
              ['Buckinghamshire', 'BKM', england_id],
              ['Berkshire', 'BRK', england_id],
              ['Bristol', 'BST', england_id],
              ['Cambridgeshire', 'CAM', england_id],
              ['Cheshire', 'CHS', england_id],
              #['Cleveland', 'CLV', england_id],
              ['Cumbria', 'CMA', england_id],
              ['Cornwall', 'CON', england_id],
              #['Cumberland', 'CUL', england_id],
              ['Derbyshire', 'DBY', england_id],
              ['Devon', 'DEV', england_id],
              ['Dorset', 'DOR', england_id],   
              ['Durham', 'DUR', england_id],
              ['East Riding of Yorkshire', 'ERY', england_id],
              ['East Sussex', 'SXE', england_id],
              ['Essex', 'ESS', england_id],
              ['Gloucestershire', 'GLS', england_id],
              ['Greater London', '', england_id],
              ['Greater Manchester', 'GTM', england_id],
              ['Hampshire', 'HAM', england_id],
              ['Herefordshire', 'HEF', england_id],
              ['Hertfordshire', 'HRT', england_id],
              #['Humberside', 'HUM', england_id],
              #['Huntingdonshire', 'HUN', england_id],
              #['Hereford and Worcester', 'HWR', england_id],
              ['Isle of Wight', 'IOW', england_id],
              ['Kent', 'KEN', england_id],
              ['Lancashire', 'LAN', england_id],
              ['Leicestershire', 'LEI', england_id],
              ['Lincolnshire', 'LIN', england_id],
              ['London', '', england_id],
              ['Merseyside', 'MSY', england_id],
              ['Northumberland', 'NBL', england_id],
              ['Norfolk', 'NFK', england_id],
              #['North Riding of Yorkshire', 'NRY', england_id],
              ['Northamptonshire', 'NTH', england_id],
              ['Nottinghamshire', 'NTT', england_id],
              ['North Yorkshire', 'NYK', england_id],
              ['Oxfordshire', 'OXF', england_id],
              ['Rutland', 'RUT', england_id],
              ['Shropshire', 'SAL', england_id],
              ['Suffolk', 'SFK', england_id],
              ['Somerset', 'SOM', england_id],
              ['South Yorkshire', 'SYK', england_id],
              ['Surrey', 'SRY', england_id],
              #['Sussex', 'SSX', england_id],
              ['Staffordshire', 'STS', england_id],
              ['Tyne and Wear', 'TWR', england_id],
              ['Warwickshire', 'WAR', england_id],   
              #['Westmorland', 'WES', england_id],
              ['West Sussex', 'SXW', england_id],
              ['West Midlands', 'WMD', england_id],
              #['West Riding of Yorkshire', 'WRY', england_id],
              ['West Yorkshire', 'WYK', england_id],
              ['Worcestershire', 'WOR', england_id],
              ['Wiltshire', 'WIL', england_id],
              #['Yorkshire', 'YKS', england_id],

              # Northern Ireland - Listed under Ireland
              ['Antrim', 'ANT', ireland_id],
              ['Armagh', 'ARM', ireland_id],
              ['Down', 'DOW', ireland_id],
              ['Fermanagh', 'FER', ireland_id],
              ['Londonderry', 'LDY', ireland_id],
              ['Tyrone', 'TYR', ireland_id],

              # Ireland
              ['Carlow', 'CAR', ireland_id],
              ['Cavan', 'CAV', ireland_id],
              ['Clare', 'CLA', ireland_id],
              ['Cork', 'COR', ireland_id],
              ['Donegal', 'DON', ireland_id],
              ['Dublin', 'DUB', ireland_id],
              ['Galway', 'GAL', ireland_id],
              ['Kerry', 'KER', ireland_id],
              ['Kildare', 'KID', ireland_id],
              ['Kilkenny', 'KIK', ireland_id],
              ['Leitrim', 'LET', ireland_id],
              ['Laois', 'LEX', ireland_id],
              ['Limerick', 'LIM', ireland_id],
              ['Longford', 'LOG', ireland_id],
              ['Louth', 'LOU', ireland_id],
              ['Mayo', 'MAY', ireland_id],
              ['Meath', 'MEA', ireland_id],
              ['Monaghan', 'MOG', ireland_id],
              ['Offaly', 'OFF', ireland_id],
              ['Roscommon', 'ROS', ireland_id],
              ['Sligo', 'SLI', ireland_id],
              ['Tipperary', 'TIP', ireland_id],
              ['Waterford', 'WAT', ireland_id],
              ['Westmeath', 'WEM', ireland_id],
              ['Wexford', 'WEX', ireland_id],
              ['Wicklow', 'WIC', ireland_id]
            ].each {|s| State.create(:name => s[0], :abbreviation => s[1], :country_id => s[2]) unless State.find_by_name(s[0]) }

            # Canadian Provinces
            ca_id = Country.find_by_abbreviation('CA').id
            [
              ['Alberta', 'AB', ca_id],
              ['British Columbia', 'BC', ca_id],
              ['Manitoba', 'MB', ca_id],
              ['New Brunswick', 'NB', ca_id],
              ['Newfoundland and Labrador', 'NL', ca_id],
              ['Northwest Territories', 'NT', ca_id],
              ['Nova Scotia', 'NS', ca_id],
              ['Nunavut', 'NU', ca_id],
              ['Ontario', 'ON', ca_id],
              ['Prince Edward Island', 'PE', ca_id],
              ['Quebec', 'QC', ca_id],
              ['Saskatchewan', 'SK', ca_id],
              ['Yukon Territory', 'YT', ca_id],
            ].each {|s| State.create(:name => s[0], :abbreviation => s[1], :country_id => s[2]) unless State.find_by_name(s[0]) }
            
            
            # Languages
            [
              ['Afar', 'Afaraf', false, 'aa', false],
              ['Аҧсуа', 'Abkhazian', false, 'ab', false],
              ['avesta', 'Avestan', false, 'ae', false],
              ['Afrikaans', 'Afrikaans', false, 'af', false],
              ['Akan', 'Akan', false, 'ak', false],
              ['አማርኛ', 'Amharic', false, 'am', false],
              ['Aragonés', 'Aragonese', false, 'an', false],
              ['العربية', 'Arabic', false, 'ar', true],
              ['অসমীয়া', 'Assamese', false, 'as', false],
              ['авар мацӀ', 'Avaric', false, 'av', false],
              ['aymar aru', 'Aymara', false, 'ay', false],
              ['azərbaycan dili', 'Azerbaijani', false, 'az', false],
              ['башҡорт теле', 'Bashkir', false, 'ba', false],
              ['Беларуская', 'Belarusian', false, 'be', false],
              ['български език', 'Bulgarian', false, 'bg', true],
              ['भोजपुरी', 'Bihari', false, 'bh', false],
              ['Bislama', 'Bislama', false, 'bi', false],
              ['bamanankan', 'Bambara', false, 'bm', false],
              ['বাংলা', 'Bengali', false, 'bn', false],
              ['བོད་ཡིག', 'Tibetan', false, 'bo', false],
              ['brezhoneg', 'Breton', false, 'br', false],
              ['bosanski jezik', 'Bosnian', false, 'bs', false],
              ['Català', 'Catalan', false, 'ca', true],
              ['нохчийн мотт', 'Chechen', false, 'ce', false],
              ['Chamoru', 'Chamorro', false, 'ch', false],
              ['corsu', 'Corsican', false, 'co', false],
              ['ᓀᐦᐃᔭᐍᐏᐣ', 'Croation', false, 'cr', true],
              ['česky', 'Czech', false, 'cs', true],
              ['ѩзыкъ словѣньскъ', 'Church', false, 'cu', false],
              ['чӑваш чӗлхи', 'Chuvash', false, 'cv', false],
              ['Cymraeg', 'Welsh', false, 'cy', false],
              ['dansk', 'Danish', false, 'da', true],
              ['Deutsch', 'German', false, 'de', true],
              ['ދިވެހި', 'Divehi', false, 'dv', false],
              ['རྫོང་ཁ', 'Dzongkha', false, 'dz', false],
              ['Ɛʋɛgbɛ', 'Ewe', false, 'ee', false],
              ['Ελληνικά', 'Greek', false, 'el', true],
              ['English', 'English', true, 'en', true],
              ['Esperanto', 'Esperanto', false, 'eo', false],
              ['Español', 'Spanish', false, 'es', true],
              ['eesti', 'Estonian', false, 'et', false],
              ['euskara', 'Basque', false, 'eu', false],
              ['فارسی', 'Persian', false, 'fa', false],
              ['Fulfulde', 'Fulah', false, 'ff', false],
              ['suomi', 'Finnish', false, 'fi', true],
              ['vosa Vakaviti', 'Fijian', false, 'fj', false],
              ['Føroyskt', 'Faroese', false, 'fo', false],
              ['Français', 'French', false, 'fr', true],
              ['Frisian', 'Western', false, 'fy', false],
              ['Gaeilge', 'Irish', false, 'ga', false],
              ['Gaelic', 'Scottish', false, 'gd', false],
              ['Galego', 'Galician', false, 'gl', false],
              ['Avañeẽ', 'Guaraní', false, 'gn', false],
              ['ગુજરાતી', 'Gujarati', false, 'gu', false],
              ['Gaelg', 'Manx', false, 'gv', false],
              ['هَوُسَ', 'Hausa', false, 'ha', false],
              ['עברית', 'Hebrew', false, 'he', true],
              ['हिन्दी', 'Hindi', false, 'hi', true],
              ['Hiri Motu', 'Hiri', false, 'ho', false],
              ['Hrvatski', 'Croatian', false, 'hr', false],
              ['Kreyòl ayisyen', 'Haitian', false, 'ht', false],
              ['Magyar', 'Hungarian', false, 'hu', false],
              ['Հայերեն', 'Armenian', false, 'hy', false],
              ['Otjiherero', 'Herero', false, 'hz', false],
              ['Bahasa Indonesia', 'Indonesian', false, 'id', true],
              ['Interlingue', 'Interlingue', false, 'ie', false],
              ['Igbo', 'Igbo', false, 'ig', false],
              ['ꆇꉙ', 'Sichuan', false, 'ii', false],
              ['Iñupiaq', 'Inupiaq', false, 'ik', false],
              ['Ido', 'Ido', false, 'io', false],
              ['Íslenska', 'Icelandic', false, 'is', false],
              ['Italiano', 'Italian', false, 'it', true],
              ['ᐃᓄᒃᑎᑐᑦ', 'Inuktitut', false, 'iu', false],
              ['日本語', 'Japanese', false, 'ja', true],
              ['basa Jawa', 'Javanese', false, 'jv', false],
              ['ქართული', 'Georgian', false, 'ka', false],
              ['KiKongo', 'Kongo', false, 'kg', false],
              ['Gĩkũyũ', 'Kikuyu', false, 'ki', false],
              ['Kuanyama', 'Kwanyama', false, 'kj', false],
              ['Қазақ тілі', 'Kazakh', false, 'kk', false],
              ['kalaallisut', 'Kalaallisut', false, 'kl', false],
              ['ភាសាខ្មែរ', 'Khmer', false, 'km', false],
              ['ಕನ್ನಡ', 'Kannada', false, 'kn', false],
              ['한국어', 'Korean', false, 'ko', true],
              ['Kanuri', 'Kanuri', false, 'kr', false],
              ['कश्मीरी', 'Kashmiri', false, 'ks', false],
              ['Kurdî', 'Kurdish', false, 'ku', false],
              ['коми кыв', 'Komi', false, 'kv', false],
              ['Kernewek', 'Cornish', false, 'kw', false],
              ['кыргыз тили', 'Kirghiz', false, 'ky', false],
              ['latine', 'Latin', false, 'la', false],
              ['Lëtzebuergesch', 'Luxembourgish', false, 'lb', false],
              ['Luganda', 'Ganda', false, 'lg', false],
              ['Limburgs', 'Limburgish', false, 'li', false],
              ['Lingála', 'Lingala', false, 'ln', false],
              ['ພາສາລາວ', 'Lao', false, 'lo', false],
              ['lietuvių kalba', 'Lithuanian', false, 'lt', true],
              ['Luba-Katanga', 'Luba-Katanga', false, 'lu', false],
              ['latviešu valoda', 'Latvian', false, 'lv', true],
              ['Malagasy fiteny', 'Malagasy', false, 'mg', false],
              ['Kajin M̧ajeļ', 'Marshallese', false, 'mh', false],
              ['te reo Māori', 'Māori', false, 'mi', false],
              ['македонски јазик', 'Macedonian', false, 'mk', false],
              ['മലയാളം', 'Malayalam', false, 'ml', false],
              ['Монгол', 'Mongolian', false, 'mn', false],
              ['मराठी', 'Marathi', false, 'mr', false],
              ['bahasa Melayu', 'Malay', false, 'ms', false],
              ['Malti', 'Maltese', false, 'mt', false],
              ['ဗမာစာ', 'Burmese', false, 'my', false],
              ['Ekakairũ Naoero', 'Nauru', false, 'na', false],
              ['Bokmål 	Norsk bokmål', 'Norwegian', false, 'nb', false],
              ['Ndebele 	isiNdebele', 'North', false, 'nd', false],
              ['नेपाली', 'Nepali', false, 'ne', false],
              ['Owambo', 'Ndonga', false, 'ng', false],
              ['Nederlands', 'Dutch', false, 'nl', true],
              ['Nynorsk 	Norsk nynorsk', 'Norwegian', false, 'nn', false],
              ['Norsk', 'Norwegian', false, 'no', true],
              ['Ndebele 	isiNdebele', 'South', false, 'nr', false],
              ['Diné bizaad', 'Navajo', false, 'nv', false],
              ['chiCheŵa', 'Chichewa', false, 'ny', false],
              ['Occitan', 'Occitan', false, 'oc', false],
              ['ᐊᓂᔑᓈᐯᒧᐎᓐ', 'Ojibwa', false, 'oj', false],
              ['Afaan Oromoo', 'Oromo', false, 'om', false],
              ['ଓଡ଼ିଆ', 'Oriya', false, 'or', false],
              ['Ирон æвзаг', 'Ossetian', false, 'os', false],
              ['ਪੰਜਾਬੀ', 'Panjabi', false, 'pa', false],
              ['पाऴि', 'Pāli', false, 'pi', false],
              ['polski', 'Polish', false, 'pl', true],
              ['پښتو', 'Pashto', false, 'ps', false],
              ['Português', 'Portuguese', false, 'pt', true],
              ['Runa Simi', 'Quechua', false, 'qu', false],
              ['rumantsch grischun', 'Raeto-Romance', false, 'rm', false],
              ['kiRundi', 'Kirundi', false, 'rn', false],
              ['română', 'Romanian', false, 'ro', true],
              ['русский язык', 'Russian', false, 'ru', true],
              ['Ikinyarwanda', 'Kinyarwanda', false, 'rw', false],
              ['संस्कृतम्', 'Sanskrit', false, 'sa', false],
              ['sardu', 'Sardinian', false, 'sc', false],
              ['सिन्धी', 'Sindhi', false, 'sd', false],
              ['Sami 	Davvisámegiella', 'Northern', false, 'se', false],
              ['yângâ tî sängö', 'Sango', false, 'sg', false],
              ['සිංහල', 'Sinhala', false, 'si', false],
              ['slovenčina', 'Slovak', false, 'sk', true],
              ['slovenščina', 'Slovenian', false, 'sl', true],
              ['gagana fa`a Samoa', 'Samoan', false, 'sm', false],
              ['chiShona', 'Shona', false, 'sn', false],
              ['Soomaaliga', 'Somali', false, 'so', false],
              ['Shqip', 'Albanian', false, 'sq', false],
              ['српски језик', 'Serbian', false, 'sr', true],
              ['SiSwati', 'Swati', false, 'ss', false],
              ['Sotho 	Sesotho', 'Southern', false, 'st', false],
              ['Basa Sunda', 'Sundanese', false, 'su', false],
              ['svenska', 'Swedish', false, 'sv', true],
              ['Kiswahili', 'Swahili', false, 'sw', false],
              ['தமிழ்', 'Tamil', false, 'ta', false],
              ['తెలుగు', 'Telugu', false, 'te', false],
              ['тоҷикӣ', 'Tajik', false, 'tg', false],
              ['ไทย', 'Thai', false, 'th', false],
              ['ትግርኛ', 'Tigrinya', false, 'ti', false],
              ['Türkmen', 'Turkmen', false, 'tk', false],
              ['Tagalog', 'Tagalog', false, 'tl', true],
              ['Setswana', 'Tswana', false, 'tn', false],
              ['faka Tonga', 'Tonga', false, 'to', false],
              ['Türkçe', 'Turkish', false, 'tr', false],
              ['Xitsonga', 'Tsonga', false, 'ts', false],
              ['татарча', 'Tatar', false, 'tt', false],
              ['Twi', 'Twi', false, 'tw', false],
              ['Reo Mā`ohi', 'Tahitian', false, 'ty', false],
              ['Uyƣurqə', 'Uighur', false, 'ug', false],
              ['Українська', 'Ukrainian', false, 'uk', true],
              ['اردو', 'Urdu', false, 'ur', false],
              ['O`zbek', 'Uzbek', false, 'uz', false],
              ['Tshivenḓa', 'Venda', false, 've', false],
              ['Tiếng Việt', 'Vietnamese', false, 'vi', true],
              ['Volapük', 'Volapük', false, 'vo', false],
              ['Walon', 'Walloon', false, 'wa', false],
              ['Wollof', 'Wolof', false, 'wo', false],
              ['isiXhosa', 'Xhosa', false, 'xh', false],
              ['ייִדיש', 'Yiddish', false, 'yi', false],
              ['Yorùbá', 'Yoruba', false, 'yo', false],
              ['Saɯ cueŋƅ', 'Zhuang', false, 'za', false],
              ['中文', 'Chinese', false, 'zh-CN', true],
              ['中文', 'Chinese Traditional', false, 'zh-TW', true],
              ['isiZulu', 'Zulu', false, 'zu', false]
            ].each {|l| Language.create(:name => l[0], :english_name => l[1], :is_default => l[2], :locale => l[3], :supported => l[4]) }

            puts 'Finished adding languages, countries and states'
          end
        end
      end
      
    end
  end
end
MuckEngine::Tasks.new