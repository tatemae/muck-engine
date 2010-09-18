require File.dirname(__FILE__) + '/../spec_helper'

class MuckEngineHelperTest < ActiveSupport::TestCase

  describe "locale_link" do

    it "should prepend the locale to a domain without a subdomain" do
      helper.request.stub(:host).and_return('folksemantic.com')
      helper.locale_link('Espanol','es').should = '<a href="http://es.folksemantic.com/">Espanol</a>'
    end

    it "should use www as the subdomain when switching to english" do
       helper.request.host = 'es.folksemantic.com'
       assert_equal '<a href="http://www.folksemantic.com/">English</a>', helper.locale_link('English','en')
     end

     it "should leave the path alone when prepending a locale subdomain" do
      helper.request.host = 'folksemantic.com'
      helper.request.request_uri = '/login'
      assert_equal '<a href="http://es.folksemantic.com/login">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should replace the www subdomain with the specified locale" do
      helper.request.host = 'www.folksemantic.com'
      assert_equal '<a href="http://es.folksemantic.com/">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should replace locale subdomains with the specified locale" do
      helper.request.host = 'fr.folksemantic.com'
      assert_equal '<a href="http://es.folksemantic.com/">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should specify the locale in the query string when the domain is localhost" do
      helper.request.host = 'localhost'
      assert_equal '<a href="http://localhost/?locale=es">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should leave the port alone when doing a locale rewrite" do
      helper.request.host = 'localhost'
      helper.request.port = '3000'
      assert_equal '<a href="http://localhost:3000/?locale=es">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should leave the port alone when doing a locale rewrite on a request that includes a path" do
      helper.request.host = 'localhost'
      helper.request.port = '3000'
      helper.request.request_uri = '/users/admin'
      assert_equal '<a href="http://localhost:3000/users/admin?locale=es">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should leave the port alone when doing a locale rewrite on a request that includes a path and already specifies a locale" do
      helper.request.host = 'localhost'
      helper.request.port = '3000'
      helper.request.request_uri = '/users/admin?locale=fr'
      helper.request.env['query_string'] = 'locale=fr'
      assert_equal '<a href="http://localhost:3000/users/admin?locale=es">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should leave the rest of the query string alone when replacing the locale parameter" do
      helper.request.host = 'localhost'
      helper.request.port = '3000'
      helper.request.request_uri = '/users/admin?test=false&locale=fr'
      assert_equal '<a href="http://localhost:3000/users/admin?test=false&amp;locale=es">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should append the locale parameter when other query string parameters are specified" do
      helper.request.host = 'localhost'
      helper.request.port = '3000'
      helper.request.request_uri = '/users/admin?test=false'
      assert_equal '<a href="http://localhost:3000/users/admin?test=false&amp;locale=es">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should replace the locale query parameter when working from localhost if another locale is already specified" do
      helper.request.host = 'localhost'
      helper.request.request_uri = '/login'
      helper.request.env['query_string'] = 'locale=fr'
      assert_equal '<a href="http://localhost/login?locale=es">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should specify the locale in the query string when the domain is an ip address" do
      helper.request.host = '155.23.322.13'
      assert_equal '<a href="http://155.23.322.13/?locale=es">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should prepend the locale if multiple submdomains are specified and the first is not www" do
      helper.request.host = 'math.folksemantic.com'
      assert_equal '<a href="http://es.math.folksemantic.com/">Espanol</a>', helper.locale_link('Espanol','es')
    end

    it "should replace the www subdomain if multiple submdomains are specified and the first is www" do
      helper.request.host = 'www.math.folksemantic.com'
      assert_equal '<a href="http://es.math.folksemantic.com/">Espanol</a>', helper.locale_link('Espanol','es')
    end

  end
end 

