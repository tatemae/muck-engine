# This file defines factories for all muck related models.  You must have the 
# muck gem installed and the related migrations run for all of these to work.
Factory.sequence :email do |n|
  "somebody#{n}@example.com"
end

Factory.sequence :login do |n|
  "inquire#{n}"
end

Factory.sequence :name do |n|
  "a_name#{n}"
end

Factory.sequence :title do |n|
  "a_title#{n}"
end

Factory.sequence :abbr do |n|
  "abbr#{n}"
end

Factory.sequence :uri do |n|
  "n#{n}.example.com"
end

Factory.sequence :description do |n|
  "This is the description: #{n}"
end

Factory.sequence :locale do |n|
  "a#{n}"
end

Factory.sequence :address do |n|
  "#{n} West #{n} South"
end

Factory.define :state do |f|
  f.name { Factory.next(:name) }
  f.abbreviation { Factory.next(:abbr) }
  f.country {|a| a.association(:country) }
end

Factory.define :country do |f|
  f.name { Factory.next(:name) }
  f.abbreviation { Factory.next(:abbr) }
end

Factory.define :language do |f|
  f.name { Factory.next(:name) }
  f.english_name { Factory.next(:name) }
  f.locale { Factory.next(:locale) }
  f.supported true
  f.muck_raker_supported true
end

Factory.define :user do |f|
  f.login { Factory.next(:login) }
  f.email { Factory.next(:email) }
  f.password 'inquire_pass'
  f.password_confirmation 'inquire_pass'
  f.first_name 'test'
  f.last_name 'guy'
  f.terms_of_service true
  f.activated_at DateTime.now
end

Factory.define :content_page do |f|
  f.creator {|a| a.association(:user)}
  f.title { Factory.next(:name) }
  f.body_raw { Factory.next(:description) }
end

Factory.define :permission do |f|
  f.role {|a| a.association(:role)}
  f.user {|a| a.association(:user)}
end

Factory.define :role do |f|
  f.rolename 'administrator'
end

Factory.define :activity do |f|
  f.item {|a| a.association(:user)}
  f.template ''
  f.source {|a| a.association(:user)}
  f.content ''
  f.title ''
  f.is_status_update false
  f.is_public true
  f.created_at DateTime.now
end

Factory.define :activity_feed do |f|
  f.activity {|a| a.association(:activity)}
  f.ownable {|a| a.association(:user)}
end

Factory.define :comment do |f|
  f.body { Factory.next(:description) }
  f.user {|a| a.association(:user)}
  f.commentable {|a| a.association(:user)}
end

Factory.define :share do |f|
  f.uri { Factory.next(:uri) }
  f.title { Factory.next(:title) }
  f.shared_by {|a| a.association(:user)}
end

Factory.define :blog do |f|
  f.title { Factory.next(:title) }
  f.blogable {|a| a.association(:user)}
end

Factory.define :domain_theme do |f|
  f.name { Factory.next(:name) }
  f.uri { Factory.next(:uri) }
end

Factory.define :theme do |f|
  f.name { Factory.next(:name) }
end

Factory.define :feed do |f|
  f.contributor { |a| a.association(:user) }
  f.uri { Factory.next(:uri) }
  f.display_uri { Factory.next(:uri) }
  f.title { Factory.next(:title) }
  f.short_title { Factory.next(:title) }
  f.description { Factory.next(:description) }
  f.top_tags { Factory.next(:name) }
  f.priority 1
  f.status 1
  f.last_requested_at DateTime.now
  f.last_harvested_at DateTime.now
  f.harvest_interval 86400
  f.failed_requests 0
  f.harvested_from_display_uri { Factory.next(:uri) }
  f.harvested_from_title { Factory.next(:title) }
  f.harvested_from_short_title { Factory.next(:title) }
  f.entries_count 0
  f.default_language { |a| a.association(:language) }
  f.default_grain_size 'unknown'
end

Factory.define :entry do |f|
  f.feed { |a| a.association(:feed) }
  f.permalink { Factory.next(:uri) }
  f.author { Factory.next(:name) }
  f.title { Factory.next(:title) }
  f.description { Factory.next(:description) }
  f.content { Factory.next(:description) }
  f.unique_content { Factory.next(:description) }
  f.published_at DateTime.now
  f.entry_updated_at DateTime.now
  f.harvested_at DateTime.now
  f.language { |a| a.association(:language) }
  f.direct_link { Factory.next(:uri) }
  f.grain_size 'unknown'
end

Factory.define :aggregation do |f|
  f.title { Factory.next(:name) }
  f.terms { Factory.next(:name) }
  f.description { Factory.next(:description) }
  f.ownable {|a| a.association(:user)}
end

Factory.define :aggregation_feed do |f|
  f.feed {|a| a.association(:feed)}
  f.aggregation {|a| a.association(:aggregation)}
end

Factory.define :oai_endpoint do |f|
  f.contributor { |a| a.association(:user) }
  f.uri { Factory.next(:uri) }
  f.display_uri { Factory.next(:uri) }
  f.title { Factory.next(:title) }
  f.short_title { Factory.next(:title) }
  f.status 1
end

Factory.define :service do |f|
  f.uri { Factory.next(:uri) }
  f.name { Factory.next(:name) }
  f.service_category { |a| a.association(:service_category) }
end

Factory.define :service_category do |f|
  f.name { Factory.next(:name) }
end

Factory.define :content do |f|
  f.creator { |a| a.association(:user) }
  f.title { Factory.next(:title) }
  f.body_raw { Factory.next(:description) }
  f.is_public true
  f.locale 'en'
end

Factory.define :content_translation do |f|
  f.content { |a| a.association(:content) }
  f.title { Factory.next(:title) }
  f.body { Factory.next(:description) }
  f.locale 'en'
end

Factory.define :content_permission do |f|
  f.content { |a| a.association(:content) }
  f.user { |a| a.association(:user) }
end

Factory.define :invitee do |f|
  f.email { Factory.next(:email) }
end

Factory.define :group do |f|
  f.creator {|a| a.association(:user)}
  f.name { Factory.next(:name) }
  f.description { Factory.next(:description) }
  f.member_count 0
end

Factory.define :membership_request do |f|
  f.group {|a| a.association(:group)}
  f.user {|a| a.association(:user)}
end

Factory.define :membership do |f|
  f.group {|a| a.association(:group)}
  f.user {|a| a.association(:user)}
  f.banned false
  f.role "member"
end