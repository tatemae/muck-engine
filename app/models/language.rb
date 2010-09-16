# == Schema Information
#
# Table name: languages
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  english_name :string(255)
#  locale       :string(255)
#  supported    :boolean         default(TRUE)
#  is_default   :integer         default(0)
#

class Language < ActiveRecord::Base
  include MuckEngine::Models::Language
end
