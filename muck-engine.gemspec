# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{muck-engine}
  s.version = "3.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Ball", "Joel Duffin"]
  s.date = %q{2011-02-26}
  s.description = %q{The base engine for the muck system.  Contains common tables, custom for, css and javascript.}
  s.email = %q{justin@tatemae.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "MIT-LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "app/controllers/admin/muck/base_controller.rb",
    "app/controllers/admin/muck/default_controller.rb",
    "app/controllers/muck/helper_controller.rb",
    "app/helpers/muck_admin_helper.rb",
    "app/helpers/muck_engine_helper.rb",
    "app/mailers/basic_mailer.rb",
    "app/views/admin/default/index.html.erb",
    "app/views/forms/_base_field.erb",
    "app/views/forms/_color_picker_field.erb",
    "app/views/forms/_default.erb",
    "app/views/forms/_field.erb",
    "app/views/forms/_field_with_tips.erb",
    "app/views/forms/_menu_field.erb",
    "app/views/forms/_tips.erb",
    "app/views/layouts/admin.html.erb",
    "app/views/layouts/admin/_footer.html.erb",
    "app/views/layouts/admin/_head.html.erb",
    "app/views/layouts/admin/_header.html.erb",
    "app/views/layouts/admin/_header_nav_item.html.erb",
    "app/views/layouts/default.html.erb",
    "app/views/layouts/email_default.html.erb",
    "app/views/layouts/email_default.text.erb",
    "app/views/layouts/frame.html.erb",
    "app/views/layouts/global/_google_analytics.html.erb",
    "app/views/layouts/global/_head.html.erb",
    "app/views/layouts/popup.html.erb",
    "app/views/scripts/_country_scripts.html.erb",
    "app/views/scripts/_parse_uri.html.erb",
    "app/views/scripts/_time_scripts.html.erb",
    "app/views/shared/_delete.erb",
    "app/views/shared/_error_box.erb",
    "app/views/shared/_field_error.erb",
    "app/views/shared/_flash_error_box.erb",
    "app/views/shared/_flash_messages.erb",
    "app/views/shared/_growl.erb",
    "app/views/shared/_growl_box.erb",
    "app/views/shared/_message_container.erb",
    "app/views/shared/_no_result.erb",
    "app/views/shared/_output_ajax_messages.erb",
    "app/views/shared/page_alert.js.erb",
    "config/locales/ar.yml",
    "config/locales/bg.yml",
    "config/locales/ca.yml",
    "config/locales/cs.yml",
    "config/locales/da.yml",
    "config/locales/de.yml",
    "config/locales/el.yml",
    "config/locales/en.yml",
    "config/locales/es.yml",
    "config/locales/et.yml",
    "config/locales/fa.yml",
    "config/locales/fi.yml",
    "config/locales/fr.yml",
    "config/locales/gl.yml",
    "config/locales/hi.yml",
    "config/locales/hr.yml",
    "config/locales/ht.yml",
    "config/locales/hu.yml",
    "config/locales/id.yml",
    "config/locales/it.yml",
    "config/locales/iw.yml",
    "config/locales/ja.yml",
    "config/locales/ko.yml",
    "config/locales/lt.yml",
    "config/locales/lv.yml",
    "config/locales/mt.yml",
    "config/locales/nl.yml",
    "config/locales/no.yml",
    "config/locales/pl.yml",
    "config/locales/pt-PT.yml",
    "config/locales/pt.yml",
    "config/locales/ro.yml",
    "config/locales/ru.yml",
    "config/locales/sk.yml",
    "config/locales/sl.yml",
    "config/locales/sq.yml",
    "config/locales/sr.yml",
    "config/locales/sv.yml",
    "config/locales/th.yml",
    "config/locales/tl.yml",
    "config/locales/tr.yml",
    "config/locales/uk.yml",
    "config/locales/vi.yml",
    "config/locales/zh-CN.yml",
    "config/locales/zh-TW.yml",
    "config/locales/zh.yml",
    "config/routes.rb",
    "db/migrate/20090402234137_create_languages.rb",
    "db/migrate/20090426041056_create_countries.rb",
    "db/migrate/20090426041103_create_states.rb",
    "lib/languages.txt",
    "lib/muck-engine.rb",
    "lib/muck-engine/config.rb",
    "lib/muck-engine/controllers/application.rb",
    "lib/muck-engine/controllers/ssl_requirement.rb",
    "lib/muck-engine/engine.rb",
    "lib/muck-engine/flash_errors.rb",
    "lib/muck-engine/form_builder.rb",
    "lib/muck-engine/json.rb",
    "lib/muck-engine/mailers/general.rb",
    "lib/muck-engine/models/country.rb",
    "lib/muck-engine/models/general.rb",
    "lib/muck-engine/models/language.rb",
    "lib/muck-engine/models/state.rb",
    "lib/muck-engine/populate.rb",
    "lib/muck-engine/rspec2.rb",
    "lib/muck-engine/test/controllers/matchers.rb",
    "lib/muck-engine/test/controllers/matchers/login_matcher.rb",
    "lib/muck-engine/test/controllers/matchers/role_matcher.rb",
    "lib/muck-engine/test/models/helpers.rb",
    "lib/muck-engine/test/models/matchers.rb",
    "lib/muck-engine/test/models/matchers/muck_matcher_base.rb",
    "lib/muck-engine/test/models/matchers/nested_attribute_matcher.rb",
    "lib/muck-engine/test/models/matchers/sanitize_matcher.rb",
    "lib/muck-engine/test/models/matchers/scope_creator_matchers.rb",
    "lib/muck-engine/test/models/matchers/scope_is_public_matchers.rb",
    "lib/muck-engine/test/models/matchers/scope_ordinal_matchers.rb",
    "lib/muck-engine/test/models/matchers/scope_sorting_matchers.rb",
    "lib/muck-engine/test/models/matchers/scope_time_matchers.rb",
    "lib/muck_test_helper.rb",
    "lib/tasks/muck_engine.rake",
    "lib/test/muck_factories.rb",
    "lib/test/muck_test_definitions.rb",
    "lib/test/muck_test_methods.rb",
    "lib/test/shoulda_macros/controller.rb",
    "lib/test/shoulda_macros/forms.rb",
    "lib/test/shoulda_macros/models.rb",
    "lib/test/shoulda_macros/pagination.rb",
    "lib/test/shoulda_macros/plugins.rb",
    "lib/test/shoulda_macros/scopes.rb",
    "muck-engine.gemspec",
    "public/javascripts/muck-countries.js",
    "public/javascripts/muck-src.js",
    "public/javascripts/muck.js",
    "public/javascripts/muck_admin.js",
    "public/javascripts/muck_time/en.js",
    "public/stylesheets/admin.css",
    "public/stylesheets/reset.css",
    "public/stylesheets/styles.css",
    "rails_i18n/ar.yml",
    "rails_i18n/bg.yml",
    "rails_i18n/bn-IN.yml",
    "rails_i18n/bs.yml",
    "rails_i18n/ca-ES.yml",
    "rails_i18n/cz.rb",
    "rails_i18n/da.yml",
    "rails_i18n/de-AT.yml",
    "rails_i18n/de.yml",
    "rails_i18n/dsb.yml",
    "rails_i18n/el.yml",
    "rails_i18n/es-AR.yml",
    "rails_i18n/es-CO.yml",
    "rails_i18n/es-MX.yml",
    "rails_i18n/es.yml",
    "rails_i18n/et.yml",
    "rails_i18n/fa.yml",
    "rails_i18n/fi.yml",
    "rails_i18n/fr-CH.yml",
    "rails_i18n/fr.yml",
    "rails_i18n/fur.yml",
    "rails_i18n/gl-ES.yml",
    "rails_i18n/he.yml",
    "rails_i18n/hr.yml",
    "rails_i18n/hsb.yml",
    "rails_i18n/hu.yml",
    "rails_i18n/id.yml",
    "rails_i18n/is.yml",
    "rails_i18n/it.yml",
    "rails_i18n/ja.yml",
    "rails_i18n/ko.yml",
    "rails_i18n/lo.yml",
    "rails_i18n/lt.yml",
    "rails_i18n/lv.yml",
    "rails_i18n/mk.yml",
    "rails_i18n/nl.rb",
    "rails_i18n/nl.yml",
    "rails_i18n/no-NB.yml",
    "rails_i18n/no-NN.yml",
    "rails_i18n/pl.yml",
    "rails_i18n/pt-BR.yml",
    "rails_i18n/pt-PT.yml",
    "rails_i18n/pt.yml",
    "rails_i18n/rm.yml",
    "rails_i18n/ro.yml",
    "rails_i18n/ru.yml",
    "rails_i18n/sk.yml",
    "rails_i18n/sr-Latn.yml",
    "rails_i18n/sr.yml",
    "rails_i18n/sv-SE.yml",
    "rails_i18n/sw.yml",
    "rails_i18n/th.rb",
    "rails_i18n/th.yml",
    "rails_i18n/tr.yml",
    "rails_i18n/uk.yml",
    "rails_i18n/vi.yml",
    "rails_i18n/zh-CN.yml",
    "rails_i18n/zh-TW.yml",
    "rails_i18n/zh.yml"
  ]
  s.homepage = %q{http://github.com/tatemae/muck-engine}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{The base engine for the muck system.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<validation_reflection>, [">= 0"])
      s.add_runtime_dependency(%q<will_paginate>, ["~> 3.0.pre2"])
      s.add_runtime_dependency(%q<overlord>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<cucumber-rails>, [">= 0"])
      s.add_development_dependency(%q<autotest>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<factory_girl>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<spork>, [">= 0"])
      s.add_development_dependency(%q<launchy>, [">= 0"])
      s.add_development_dependency(%q<muck-users>, [">= 0"])
      s.add_development_dependency(%q<git>, [">= 0"])
    else
      s.add_dependency(%q<validation_reflection>, [">= 0"])
      s.add_dependency(%q<will_paginate>, ["~> 3.0.pre2"])
      s.add_dependency(%q<overlord>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<cucumber-rails>, [">= 0"])
      s.add_dependency(%q<autotest>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<factory_girl>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<spork>, [">= 0"])
      s.add_dependency(%q<launchy>, [">= 0"])
      s.add_dependency(%q<muck-users>, [">= 0"])
      s.add_dependency(%q<git>, [">= 0"])
    end
  else
    s.add_dependency(%q<validation_reflection>, [">= 0"])
    s.add_dependency(%q<will_paginate>, ["~> 3.0.pre2"])
    s.add_dependency(%q<overlord>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<cucumber-rails>, [">= 0"])
    s.add_dependency(%q<autotest>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<factory_girl>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<spork>, [">= 0"])
    s.add_dependency(%q<launchy>, [">= 0"])
    s.add_dependency(%q<muck-users>, [">= 0"])
    s.add_dependency(%q<git>, [">= 0"])
  end
end

