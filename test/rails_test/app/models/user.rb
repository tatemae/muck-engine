class User < ActiveRecord::Base
  acts_as_authentic
  include MuckUsers::Models::User
end
