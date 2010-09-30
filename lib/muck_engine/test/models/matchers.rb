require 'muck_engine/test/models/helpers'
require 'muck_engine/test/models/matchers/scope_matcher_base'
require 'muck_engine/test/models/matchers/scope_creator_matchers'
require 'muck_engine/test/models/matchers/scope_is_public_matchers'
require 'muck_engine/test/models/matchers/scope_ordinal_matchers'
require 'muck_engine/test/models/matchers/scope_sorting_matchers'
require 'muck_engine/test/models/matchers/scope_time_matchers'


module MuckEngine # :nodoc:
  module Models # :nodoc:
    # = Matchers for common active record scopes:
    #
    #   scope :by_title, order("title ASC")
    #   scope :by_name, order("name ASC")
    #   scope :by_newest, order("created_at DESC")
    #   scope :by_oldest, order("created_at ASC")
    #   scope :by_latest, order("updated_at DESC")
    #   scope :newer_than, lambda { |*args| where("created_at > ?", args.first || DateTime.now) }
    #   scope :older_than, lambda { |*args| where("created_at < ?", args.first || 1.day.ago.to_s(:db)) }
    #   scope :is_public, where(["is_public = ?", true])
    #   scope :created_by, lambda { |creator| where("creator_id = ? AND creator_type = ?", creator.id, creator.class.to_s) } }
    #   scope :sorted, order("sort ASC")
    #
    # These matchers will test common scopes used in active record models:
    #
    #   describe User do
    #     it { should scope_by_title }
    #     it { should scope_by_name }
    #     it { should scope_by_latest }
    #     it { should scope_by_newest }
    #     it { should scope_by_oldest }
    
    #     it { should scope_newer_than }
    #     it { should scope_older_than }
    
    #     it { should scope_is_public }
    
    #     it { should scope_created_by }
    
    #   end
    #
    module Matchers
    end
  end
end