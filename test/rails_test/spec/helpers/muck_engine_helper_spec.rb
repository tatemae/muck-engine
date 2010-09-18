require File.dirname(__FILE__) + '/../spec_helper'

class MuckEngineHelperTest < ActiveSupport::TestCase

  describe "http_protocol" do
    describe "secure request" do
      it "returns https when ssl is true" do
        helper.http_protocol(true).should == 'https://'
      end
      it "returns https when request is ssl" do
        helper.request.should_receive(:ssl?).and_return(true)
        helper.http_protocol.should == 'https://'
      end
    end
    describe "normal request" do
      it "returns http when ssl is false" do
        helper.http_protocol(false).should == 'http://'
      end
      it "returns http when request is not ssl" do
        helper.request.should_receive(:ssl?).and_return(false)
        helper.http_protocol.should == 'http://'
      end
    end
  end
  
  describe "jquery_json_message" do
    it "shouldn't render growl" do
      MuckEngine.configuration.growl_enabled = false
      message_dom_id = "user_12"
      helper.jquery_json_message(message_dom_id).should include(message_dom_id)
      helper.jquery_json_message(message_dom_id).should include("html(json.message);")
      helper.jquery_json_message(message_dom_id).should include("show();")
    end
    it "should render growl" do
      MuckEngine.configuration.growl_enabled = true
      helper.jquery_json_message.should include("jGrowl")
    end
  end
  
  describe "locale_link" do
    it "should prepend the locale to a domain without a subdomain" do
      helper.request.stub(:host).and_return('folksemantic.com')
      helper.locale_link('Espanol','es').should == '<a href="http://es.folksemantic.com">Espanol</a>'
    end
    it "should use www as the subdomain when switching to english" do
      helper.request.host = 'es.folksemantic.com'
      Language.should_receive(:supported_locale?).with('es').and_return(true)
      helper.locale_link('English','en').should == '<a href="http://www.folksemantic.com">English</a>'
    end
    it "should leave the path alone when prepending a locale subdomain" do
      helper.request.host = 'folksemantic.com'
      helper.request.stub!(:fullpath).and_return('/login')
      helper.locale_link('Espanol','es').should == '<a href="http://es.folksemantic.com/login">Espanol</a>'
    end
    it "should replace the www subdomain with the specified locale" do
      helper.request.host = 'www.folksemantic.com'
      helper.locale_link('Espanol','es').should == '<a href="http://es.folksemantic.com">Espanol</a>'
    end
    it "should replace locale subdomains with the specified locale" do
      helper.request.host = 'fr.folksemantic.com'
      Language.should_receive(:supported_locale?).with('fr').and_return(true)
      helper.locale_link('Espanol','es').should == '<a href="http://es.folksemantic.com">Espanol</a>'
    end
    it "should specify the locale in the query string when the domain is localhost" do
      helper.request.host = 'localhost'
      helper.locale_link('Espanol','es').should == '<a href="http://localhost?locale=es">Espanol</a>'
    end
    it "should replace the locale query parameter when working from localhost if another locale is already specified" do
      helper.request.host = 'localhost'
      helper.request.stub!(:fullpath).and_return('/login')
      helper.request.env['query_string'] = 'locale=fr'
      helper.locale_link('Espanol','es').should == '<a href="http://localhost/login?locale=es">Espanol</a>'
    end
    it "should specify the locale in the query string when the domain is an ip address" do
      helper.request.host = '155.23.322.13'
      helper.locale_link('Espanol','es').should == '<a href="http://155.23.322.13?locale=es">Espanol</a>'
    end
    it "should prepend the locale if multiple submdomains are specified and the first is not www" do
      helper.request.host = 'math.folksemantic.com'
      helper.locale_link('Espanol','es').should == '<a href="http://es.math.folksemantic.com">Espanol</a>'
    end
    it "should replace the www subdomain if multiple submdomains are specified and the first is www" do
      helper.request.host = 'www.math.folksemantic.com'
      helper.locale_link('Espanol','es').should == '<a href="http://es.math.folksemantic.com">Espanol</a>'
    end
    describe "localhost:3000" do
      it "should leave the port alone when doing a locale rewrite" do
        helper.request.host = 'localhost'
        helper.request.port = 3000
        helper.request.stub(:host_with_port).and_return("localhost:3000")
        helper.locale_link('Espanol','es').should == '<a href="http://localhost:3000?locale=es">Espanol</a>'
      end
      it "should leave the port alone when doing a locale rewrite on a request that includes a path" do
        helper.request.host = 'localhost'
        helper.request.port = 3000
        helper.request.stub(:host_with_port).and_return("localhost:3000")
        helper.request.stub!(:fullpath).and_return('/users/admin')
        helper.locale_link('Espanol','es').should == '<a href="http://localhost:3000/users/admin?locale=es">Espanol</a>'
      end
      it "should leave the port alone when doing a locale rewrite on a request that includes a path and already specifies a locale" do
        helper.request.host = 'localhost'
        helper.request.port = 3000
        helper.request.stub(:host_with_port).and_return("localhost:3000")
        helper.request.stub!(:fullpath).and_return('/users/admin?locale=fr')
        helper.request.env['query_string'] = 'locale=fr'
        helper.locale_link('Espanol','es').should == '<a href="http://localhost:3000/users/admin?locale=es">Espanol</a>'
      end
      it "should leave the rest of the query string alone when replacing the locale parameter" do
        helper.request.host = 'localhost'
        helper.request.port = 3000
        helper.request.stub(:host_with_port).and_return("localhost:3000")
        helper.request.stub!(:fullpath).and_return('/users/admin?test=false&locale=fr')
        helper.locale_link('Espanol','es').should == '<a href="http://localhost:3000/users/admin?test=false&amp;locale=es">Espanol</a>'
      end
      it "should append the locale parameter when other query string parameters are specified" do
        helper.request.host = 'localhost'
        helper.request.port = 3000
        helper.request.stub(:host_with_port).and_return("localhost:3000")
        helper.request.stub!(:fullpath).and_return('/users/admin?test=false')
        helper.locale_link('Espanol','es').should == '<a href="http://localhost:3000/users/admin?test=false&amp;locale=es">Espanol</a>'
      end
    end
  end
end 

