# This file defines factories for all muck related models.  You must have the 
# muck gem installed and the related migrations run for all of these to work.
FactoryGirl.define do
  
  sequence :email do |n|
    "somebody#{n}@example.com"
  end

  sequence :login do |n|
    "inquire#{n}"
  end

  sequence :name do |n|
    "a_name#{n}"
  end

  sequence :title do |n|
    "a_title#{n}"
  end

  sequence :abbr do |n|
    "abbr#{n}"
  end

  sequence :uri do |n|
    "n#{n}.example.com"
  end

  sequence :description do |n|
    "This is the description: #{n}"
  end

  sequence :locale do |n|
    "a#{n}"
  end

  sequence :address do |n|
    "#{n} West #{n} South"
  end

  factory :state do
    name { Factory.next(:name) }
    abbreviation { Factory.next(:abbr) }
    country {|a| a.association(:country) }
  end

  factory :country do
    name { Factory.next(:name) }
    abbreviation { Factory.next(:abbr) }
  end

  factory :language do
    name { Factory.next(:name) }
    english_name { Factory.next(:name) }
    locale { Factory.next(:locale) }
    supported true
    muck_raker_supported true
  end

  # This is used for tests within muck-engine. The language
  # model is modified by migrations in other gems to include 'muck_raker_supported'
  factory :unmodified_language, :class => Language do
    name { Factory.next(:name) }
    english_name { Factory.next(:name) }
    locale { Factory.next(:locale) }
    supported true
  end

  factory :user do
    login { Factory.next(:login) }
    email { Factory.next(:email) }
    password 'inquire_pass'
    password_confirmation 'inquire_pass'
    first_name 'test'
    last_name 'guy'
    terms_of_service true
    activated_at DateTime.now
  end

  factory :profile do
    user {|a| a.association(:user)}
    photo fixture_file_upload("#{::Rails.root}/public/images/profile_default.jpg", 'image/jpg')
    location 'Jackson Hole, WY'
    about 'A great person'
    city 'Jackson Hole'
    state {|a| a.association(:state)}
    country {|a| a.association(:country)}
  #  language {|a| a.association(:language)}
    policy 'a great policy'
  end

  factory :content_page do
    creator {|a| a.association(:user)}
    title { Factory.next(:name) }
    body_raw { Factory.next(:description) }
  end

  factory :permission do
    role {|a| a.association(:role)}
    user {|a| a.association(:user)}
  end

  factory :role do
    rolename { Factory.next(:name) }
  end

  factory :access_code do
    code { Factory.next(:name) }
    uses 0
    unlimited false
    expires_at  { DateTime.now + 2.weeks }
    use_limit 1
  end

  factory :access_code_request do
    email { Factory.next(:email) }
  end

  factory :activity do
    item {|a| a.association(:user)}
    template ''
    source {|a| a.association(:user)}
    content ''
    title ''
    is_status_update false
    is_public true
    created_at DateTime.now
  end

  factory :activity_feed do
    activity {|a| a.association(:activity)}
    ownable {|a| a.association(:user)}
  end

  factory :comment do
    body { Factory.next(:description) }
    user {|a| a.association(:user)}
    commentable {|a| a.association(:user)}
  end

  factory :share do
    uri { Factory.next(:uri) }
    title { Factory.next(:title) }
    shared_by {|a| a.association(:user)}
  end

  factory :blog do
    title { Factory.next(:title) }
    blogable {|a| a.association(:user)}
  end

  factory :domain_theme do
    name { Factory.next(:name) }
    uri { Factory.next(:uri) }
  end

  factory :theme do
    name { Factory.next(:name) }
  end

  factory :feed do
    contributor { |a| a.association(:user) }
    uri { Factory.next(:uri) }
    display_uri { Factory.next(:uri) }
    title { Factory.next(:title) }
    short_title { Factory.next(:title) }
    description { Factory.next(:description) }
    top_tags { Factory.next(:name) }
    priority 1
    status 1
    last_requested_at DateTime.now
    last_harvested_at DateTime.now
    harvest_interval 86400
    failed_requests 0
    harvested_from_display_uri { Factory.next(:uri) }
    harvested_from_title { Factory.next(:title) }
    harvested_from_short_title { Factory.next(:title) }
    entries_count 0
    default_language { |a| a.association(:language) }
    default_grain_size 'unknown'
  end

  factory :entry do
    feed { |a| a.association(:feed) }
    permalink { Factory.next(:uri) }
    author { Factory.next(:name) }
    title { Factory.next(:title) }
    description { Factory.next(:description) }
    content { Factory.next(:description) }
    unique_content { Factory.next(:description) }
    published_at DateTime.now
    entry_updated_at DateTime.now
    harvested_at DateTime.now
    language { |a| a.association(:language) }
    direct_link { Factory.next(:uri) }
    grain_size 'unknown'
  end

  factory :aggregation do
    title { Factory.next(:name) }
    terms { Factory.next(:name) }
    description { Factory.next(:description) }
    ownable {|a| a.association(:user)}
  end

  factory :aggregation_feed do
    feed {|a| a.association(:feed)}
    aggregation {|a| a.association(:aggregation)}
  end

  factory :oai_endpoint do
    contributor { |a| a.association(:user) }
    uri { Factory.next(:uri) }
    display_uri { Factory.next(:uri) }
    title { Factory.next(:title) }
    short_title { Factory.next(:title) }
    status 1
  end

  factory :service do
    uri { Factory.next(:uri) }
    name { Factory.next(:name) }
    service_category { |a| a.association(:service_category) }
  end

  factory :service_category do
    name { Factory.next(:name) }
  end

  factory :content do
    creator { |a| a.association(:user) }
    title { Factory.next(:title) }
    body_raw { Factory.next(:description) }
    is_public true
    locale 'en'
  end

  factory :content_translation do
    content { |a| a.association(:content) }
    title { Factory.next(:title) }
    body { Factory.next(:description) }
    locale 'en'
  end

  factory :content_permission do
    content { |a| a.association(:content) }
    user { |a| a.association(:user) }
  end

  factory :invitee do
    email { Factory.next(:email) }
  end

  factory :group do
    creator {|a| a.association(:user)}
    name { Factory.next(:name) }
    description { Factory.next(:description) }
    member_count 0
  end

  factory :membership_request do
    group {|a| a.association(:group)}
    user {|a| a.association(:user)}
  end

  factory :membership do
    group {|a| a.association(:group)}
    user {|a| a.association(:user)}
    banned false
    role "member"
  end

  factory :authentication do
    authenticatable {|a| a.association(:user)}
    provider 'twitter'
    name { Factory.next(:name) }
    uid { Factory.next(:uri) }
    token { Factory.next(:uri) }
    secret { Factory.next(:uri) }
    raw_auth { Factory.next(:description) }
  end
  
end