require 'muck-engine/test/models/matchers'
require 'muck-engine/test/controllers/matchers'
#require 'muck-engine/test/action_mailer/matchers'

RSpec.configure do |config|
  config.include(MuckEngine::Models::Matchers)
  config.include(MuckEngine::Controllers::Matchers)
  config.color_enabled = true
end