require 'muck_engine/test/controllers/matchers/login_matcher'
require 'muck_engine/test/controllers/matchers/role_matcher'

module MuckEngine # :nodoc:
  module Controllers # :nodoc:
    # = Matchers for common controller methods:
    #
    #   describe UsersController, "on GET to show with a valid id" do
    #
    #     it { should require_login :index, :get }
    #     it { should require_role('admin', :index, :get) }
    #   end
    #
    module Matchers
    end
  end
end
