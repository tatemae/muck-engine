require 'muck_engine/test/controllers/matchers/login_matcher'
require 'muck_engine/test/controllers/matchers/role_matcher'
require 'muck_engine/test/controllers/matchers/render_partial_text_matcher'
require 'muck_engine/test/controllers/matchers/render_text_matcher'

module MuckEngine # :nodoc:
  module Controllers # :nodoc:
    # = Matchers for common controller methods:
    #
    #   describe UsersController, "on GET to show with a valid id" do
    #
    #     it { should require_login :index, :get }
    #     it { should require_role('admin', :index, :get) }
    #     it { should render_partial_text('some text in the page') }
    #     it { should render_text('exact text in the page') }
    #   end
    #
    module Matchers
    end
  end
end
