require 'muck_engine/test/models/helpers'
require 'muck_engine/test/models/matchers/scope_matchers'


module MuckEngine # :nodoc:
  module Models # :nodoc:
    # = Matchers for common active record scopes:
    #
    #   scope :by_title, order("title ASC")
    #   scope :by_name, order("name ASC")
    #   scope :recent, lambda { |*args| where("created_at > ?", args.first || 7.days.ago.to_s(:db)) }
    #   scope :newest, order("created_at DESC")
    #   scope :oldest, order("items.created_at ASC")
    #   scope :latest, order("items.updated_at DESC")
    #   scope :before, lambda { |*args| where("created_at < ?", args.first || DateTime.now) }
    #   scope :since, lambda { |*args| where("created_at > ?", args.first || 1.day.ago.to_s(:db)) }
    #   scope :only_public, where(["is_public = ?", true])
    #   scope :created_by, lambda { |creator| where("creator_id = ? AND creator_type = ?", creator.id, creator.class.to_s) } }
    #   scope :created_by, lambda { |creator_id| where("creator_id = ?", creator_id) }
    #   scope :sorted, order("sort ASC")
    #
    # These matchers will test common scopes used in active record models:
    #
    #   describe User do
    #     it { "should scope_by_title }
    #     it { "should scope_by_alpha_title }
    #     it { "should scope_by_name }
    #     it { "should scope_latest }
    #     it { "should scope_newest }
    #     it { "should scope_by_newest }
    #     it { "should scope_oldest }
    #     it { "should scope_by_oldest }
    #     it { "should scope_recent }
    #     it { "should scope_before }
    #     it { "should scope_since }
    #     it { "should scope_only_public }
    #     it { "should scope_public }
    #     it { "should scope_created_by }
    #     it { "should scope_by_creator }
    #     it { "should scope_sorted }
    #   end
    #
    module Matchers
    end
  end
end