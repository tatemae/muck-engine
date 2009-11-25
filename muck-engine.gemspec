# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{muck-engine}
  s.version = "0.2.16"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Ball", "Joel Duffin"]
  s.date = %q{2009-11-25}
  s.description = %q{The base engine for the muck system.  Contains common tables, custom for, css and javascript.}
  s.email = %q{justin@tatemae.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "app/controllers/admin/muck/base_controller.rb",
     "app/controllers/admin/muck/base_controller.rb",
     "app/controllers/muck/helper_controller.rb",
     "app/controllers/muck/helper_controller.rb",
     "app/helpers/muck_custom_form_builder.rb",
     "app/helpers/muck_custom_form_builder.rb",
     "app/helpers/muck_engine_helper.rb",
     "app/helpers/muck_engine_helper.rb",
     "app/models/basic_mailer.rb",
     "app/models/basic_mailer.rb",
     "app/models/country.rb",
     "app/models/country.rb",
     "app/models/language.rb",
     "app/models/language.rb",
     "app/models/state.rb",
     "app/models/state.rb",
     "app/views/forms/_base_field.html.erb",
     "app/views/forms/_base_field.html.erb",
     "app/views/forms/_color_picker_field.html.erb",
     "app/views/forms/_color_picker_field.html.erb",
     "app/views/forms/_default.html.erb",
     "app/views/forms/_default.html.erb",
     "app/views/forms/_field.html.erb",
     "app/views/forms/_field.html.erb",
     "app/views/forms/_field_with_tips.html.erb",
     "app/views/forms/_field_with_tips.html.erb",
     "app/views/forms/_menu_field.html.erb",
     "app/views/forms/_menu_field.html.erb",
     "app/views/forms/_tips.html.erb",
     "app/views/forms/_tips.html.erb",
     "app/views/layouts/admin.html.erb",
     "app/views/layouts/admin.html.erb",
     "app/views/layouts/default.html.erb",
     "app/views/layouts/default.html.erb",
     "app/views/layouts/email_default.text.html.erb",
     "app/views/layouts/email_default.text.html.erb",
     "app/views/layouts/email_default.text.plain.erb",
     "app/views/layouts/email_default.text.plain.erb",
     "app/views/layouts/frame.html.erb",
     "app/views/layouts/frame.html.erb",
     "app/views/layouts/global/_google_analytics.html.erb",
     "app/views/layouts/global/_google_analytics.html.erb",
     "app/views/layouts/global/_head.html.erb",
     "app/views/layouts/global/_head.html.erb",
     "app/views/layouts/popup.html.erb",
     "app/views/layouts/popup.html.erb",
     "app/views/scripts/_parse_uri.html.erb",
     "app/views/scripts/_parse_uri.html.erb",
     "app/views/scripts/_time_scripts.html.erb",
     "app/views/scripts/_time_scripts.html.erb",
     "app/views/shared/_delete.html.erb",
     "app/views/shared/_delete.html.erb",
     "app/views/shared/_error_box.html.erb",
     "app/views/shared/_error_box.html.erb",
     "app/views/shared/_field_error.html.erb",
     "app/views/shared/_field_error.html.erb",
     "app/views/shared/_flash_error_box.html.erb",
     "app/views/shared/_flash_error_box.html.erb",
     "app/views/shared/_flash_messages.html.erb",
     "app/views/shared/_flash_messages.html.erb",
     "app/views/shared/_growl.html.erb",
     "app/views/shared/_growl.html.erb",
     "app/views/shared/_growl_box.html.erb",
     "app/views/shared/_growl_box.html.erb",
     "app/views/shared/_no_result.html.erb",
     "app/views/shared/_no_result.html.erb",
     "db/migrate/20090402234137_create_languages.rb",
     "db/migrate/20090402234137_create_languages.rb",
     "db/migrate/20090426041056_create_countries.rb",
     "db/migrate/20090426041056_create_countries.rb",
     "db/migrate/20090426041103_create_states.rb",
     "db/migrate/20090426041103_create_states.rb",
     "install.rb",
     "lib/action_controller/muck_application.rb",
     "lib/action_controller/muck_application.rb",
     "lib/active_record/muck_model.rb",
     "lib/active_record/muck_model.rb",
     "lib/muck_engine.rb",
     "lib/muck_engine.rb",
     "lib/muck_engine/initialize_routes.rb",
     "lib/muck_engine/initialize_routes.rb",
     "lib/muck_engine/tasks.rb",
     "lib/muck_engine/tasks.rb",
     "lib/muck_test_helper.rb",
     "lib/muck_test_helper.rb",
     "lib/test/muck_factories.rb",
     "lib/test/muck_factories.rb",
     "lib/test/muck_test_definitions.rb",
     "lib/test/muck_test_definitions.rb",
     "lib/test/muck_test_methods.rb",
     "lib/test/muck_test_methods.rb",
     "lib/test/shoulda_macros/controller.rb",
     "lib/test/shoulda_macros/controller.rb",
     "lib/test/shoulda_macros/forms.rb",
     "lib/test/shoulda_macros/forms.rb",
     "lib/test/shoulda_macros/models.rb",
     "lib/test/shoulda_macros/models.rb",
     "lib/test/shoulda_macros/pagination.rb",
     "lib/test/shoulda_macros/pagination.rb",
     "lib/test/shoulda_macros/plugins.rb",
     "lib/test/shoulda_macros/plugins.rb",
     "locales/ar.yml",
     "locales/ar.yml",
     "locales/bg.yml",
     "locales/bg.yml",
     "locales/ca.yml",
     "locales/ca.yml",
     "locales/cs.yml",
     "locales/cs.yml",
     "locales/da.yml",
     "locales/da.yml",
     "locales/de.yml",
     "locales/de.yml",
     "locales/el.yml",
     "locales/el.yml",
     "locales/en.yml",
     "locales/en.yml",
     "locales/es.yml",
     "locales/es.yml",
     "locales/et.yml",
     "locales/et.yml",
     "locales/fa.yml",
     "locales/fa.yml",
     "locales/fi.yml",
     "locales/fi.yml",
     "locales/fr.yml",
     "locales/fr.yml",
     "locales/gl.yml",
     "locales/gl.yml",
     "locales/hi.yml",
     "locales/hi.yml",
     "locales/hr.yml",
     "locales/hr.yml",
     "locales/hu.yml",
     "locales/hu.yml",
     "locales/id.yml",
     "locales/id.yml",
     "locales/it.yml",
     "locales/it.yml",
     "locales/iw.yml",
     "locales/iw.yml",
     "locales/ja.yml",
     "locales/ja.yml",
     "locales/ko.yml",
     "locales/ko.yml",
     "locales/lt.yml",
     "locales/lt.yml",
     "locales/lv.yml",
     "locales/lv.yml",
     "locales/mt.yml",
     "locales/mt.yml",
     "locales/nl.yml",
     "locales/nl.yml",
     "locales/no.yml",
     "locales/no.yml",
     "locales/pl.yml",
     "locales/pl.yml",
     "locales/pt-PT.yml",
     "locales/pt-PT.yml",
     "locales/pt.yml",
     "locales/pt.yml",
     "locales/ro.yml",
     "locales/ro.yml",
     "locales/ru.yml",
     "locales/ru.yml",
     "locales/sk.yml",
     "locales/sk.yml",
     "locales/sl.yml",
     "locales/sl.yml",
     "locales/sq.yml",
     "locales/sq.yml",
     "locales/sr.yml",
     "locales/sr.yml",
     "locales/sv.yml",
     "locales/sv.yml",
     "locales/th.yml",
     "locales/th.yml",
     "locales/tl.yml",
     "locales/tl.yml",
     "locales/tr.yml",
     "locales/tr.yml",
     "locales/uk.yml",
     "locales/uk.yml",
     "locales/vi.yml",
     "locales/vi.yml",
     "locales/zh-CN.yml",
     "locales/zh-CN.yml",
     "locales/zh-TW.yml",
     "locales/zh-TW.yml",
     "locales/zh.yml",
     "locales/zh.yml",
     "muck-engine.gemspec",
     "public/images/arrow_down.gif",
     "public/images/arrow_left.gif",
     "public/images/arrow_right.gif",
     "public/images/arrow_up.gif",
     "public/images/fancybox/fancy_closebox.png",
     "public/images/fancybox/fancy_left.png",
     "public/images/fancybox/fancy_progress.png",
     "public/images/fancybox/fancy_right.png",
     "public/images/fancybox/fancy_shadow_e.png",
     "public/images/fancybox/fancy_shadow_n.png",
     "public/images/fancybox/fancy_shadow_ne.png",
     "public/images/fancybox/fancy_shadow_nw.png",
     "public/images/fancybox/fancy_shadow_s.png",
     "public/images/fancybox/fancy_shadow_se.png",
     "public/images/fancybox/fancy_shadow_sw.png",
     "public/images/fancybox/fancy_shadow_w.png",
     "public/images/fancybox/fancy_title_left.png",
     "public/images/fancybox/fancy_title_main.png",
     "public/images/fancybox/fancy_title_right.png",
     "public/images/icons/accept.png",
     "public/images/icons/add.png",
     "public/images/icons/blue_guy.png",
     "public/images/icons/button_background.png",
     "public/images/icons/cancel.png",
     "public/images/icons/close.png",
     "public/images/icons/comment.png",
     "public/images/icons/delete.png",
     "public/images/icons/exclaim.png",
     "public/images/icons/external.png",
     "public/images/icons/feed.png",
     "public/images/icons/grey_guy.png",
     "public/images/icons/hide.png",
     "public/images/icons/information.png",
     "public/images/icons/minus.png",
     "public/images/icons/pending.png",
     "public/images/icons/question.png",
     "public/images/icons/search_box.png",
     "public/images/icons/star.png",
     "public/images/icons/stop.png",
     "public/images/icons/thumb_down.png",
     "public/images/icons/thumb_up.png",
     "public/images/icons/vote.png",
     "public/images/loading.gif",
     "public/images/nothing.png",
     "public/images/spinner.gif",
     "public/images/sprites.png",
     "public/javascripts/fancyzoom.min.js",
     "public/javascripts/fancyzoom.min.js",
     "public/javascripts/jquery/colorpicker.js",
     "public/javascripts/jquery/jquery-ui.js",
     "public/javascripts/jquery/jquery.autocomplete.js.readme",
     "public/javascripts/jquery/jquery.autocomplete.min.js",
     "public/javascripts/jquery/jquery.autocomplete.pack.js",
     "public/javascripts/jquery/jquery.easing.js",
     "public/javascripts/jquery/jquery.fancybox.js",
     "public/javascripts/jquery/jquery.form.js",
     "public/javascripts/jquery/jquery.jgrowl.js",
     "public/javascripts/jquery/jquery.js",
     "public/javascripts/jquery/jquery.metadata.min.js",
     "public/javascripts/jquery/jquery.queryString.js",
     "public/javascripts/jquery/jquery.swapimage.js",
     "public/javascripts/jquery/jquery.swapimage.min.js",
     "public/javascripts/jquery/jquery.tips.js",
     "public/javascripts/jquery/jrails.js",
     "public/javascripts/muck.js",
     "public/javascripts/muck.js",
     "public/javascripts/muck_time/en.js",
     "public/javascripts/tree.js",
     "public/javascripts/tree.js",
     "public/stylesheets/admin.css",
     "public/stylesheets/blueprint/ie.css",
     "public/stylesheets/blueprint/liquid_screen.css",
     "public/stylesheets/blueprint/plugins/buttons/icons/cross.png",
     "public/stylesheets/blueprint/plugins/buttons/icons/key.png",
     "public/stylesheets/blueprint/plugins/buttons/icons/tick.png",
     "public/stylesheets/blueprint/plugins/buttons/readme.txt",
     "public/stylesheets/blueprint/plugins/buttons/screen.css",
     "public/stylesheets/blueprint/plugins/fancy-type/readme.txt",
     "public/stylesheets/blueprint/plugins/fancy-type/screen.css",
     "public/stylesheets/blueprint/plugins/link-icons/icons/doc.png",
     "public/stylesheets/blueprint/plugins/link-icons/icons/email.png",
     "public/stylesheets/blueprint/plugins/link-icons/icons/external.png",
     "public/stylesheets/blueprint/plugins/link-icons/icons/feed.png",
     "public/stylesheets/blueprint/plugins/link-icons/icons/im.png",
     "public/stylesheets/blueprint/plugins/link-icons/icons/pdf.png",
     "public/stylesheets/blueprint/plugins/link-icons/icons/visited.png",
     "public/stylesheets/blueprint/plugins/link-icons/icons/xls.png",
     "public/stylesheets/blueprint/plugins/link-icons/readme.txt",
     "public/stylesheets/blueprint/plugins/link-icons/screen.css",
     "public/stylesheets/blueprint/plugins/liquid/liquid.css",
     "public/stylesheets/blueprint/plugins/liquid/src/liquid.css",
     "public/stylesheets/blueprint/plugins/rtl/readme.txt",
     "public/stylesheets/blueprint/plugins/rtl/screen.css",
     "public/stylesheets/blueprint/print.css",
     "public/stylesheets/blueprint/screen.css",
     "public/stylesheets/blueprint/sprite.css",
     "public/stylesheets/blueprint/src/forms.css",
     "public/stylesheets/blueprint/src/grid.css",
     "public/stylesheets/blueprint/src/grid.png",
     "public/stylesheets/blueprint/src/ie.css",
     "public/stylesheets/blueprint/src/print.css",
     "public/stylesheets/blueprint/src/reset.css",
     "public/stylesheets/blueprint/src/typography.css",
     "public/stylesheets/jquery/cupertino/images/ui-bg_diagonals-small_0_aaaaaa_40x40.png",
     "public/stylesheets/jquery/cupertino/images/ui-bg_diagonals-thick_15_444444_40x40.png",
     "public/stylesheets/jquery/cupertino/images/ui-bg_glass_100_f0f0f0_1x400.png",
     "public/stylesheets/jquery/cupertino/images/ui-bg_glass_50_99c2ff_1x400.png",
     "public/stylesheets/jquery/cupertino/images/ui-bg_glass_55_fbf5d0_1x400.png",
     "public/stylesheets/jquery/cupertino/images/ui-bg_glass_80_e6e6e6_1x400.png",
     "public/stylesheets/jquery/cupertino/images/ui-bg_glass_95_fef1ec_1x400.png",
     "public/stylesheets/jquery/cupertino/images/ui-bg_highlight-hard_100_f9f9f9_1x100.png",
     "public/stylesheets/jquery/cupertino/images/ui-bg_highlight-soft_100_e7eef3_1x100.png",
     "public/stylesheets/jquery/cupertino/images/ui-icons_222222_256x240.png",
     "public/stylesheets/jquery/cupertino/images/ui-icons_2694e8_256x240.png",
     "public/stylesheets/jquery/cupertino/images/ui-icons_2e83ff_256x240.png",
     "public/stylesheets/jquery/cupertino/images/ui-icons_72a7cf_256x240.png",
     "public/stylesheets/jquery/cupertino/images/ui-icons_888888_256x240.png",
     "public/stylesheets/jquery/cupertino/images/ui-icons_cd0a0a_256x240.png",
     "public/stylesheets/jquery/cupertino/images/ui-icons_ffffff_256x240.png",
     "public/stylesheets/jquery/cupertino/jquery-ui-1.7.1.custom.css",
     "public/stylesheets/jquery/jquery.autocomplete.css",
     "public/stylesheets/jquery/jquery.fancybox.css",
     "public/stylesheets/jquery/redmond/images/ui-bg_flat_0_aaaaaa_40x100.png",
     "public/stylesheets/jquery/redmond/images/ui-bg_flat_55_fbec88_40x100.png",
     "public/stylesheets/jquery/redmond/images/ui-bg_glass_75_d0e5f5_1x400.png",
     "public/stylesheets/jquery/redmond/images/ui-bg_glass_85_dfeffc_1x400.png",
     "public/stylesheets/jquery/redmond/images/ui-bg_glass_95_fef1ec_1x400.png",
     "public/stylesheets/jquery/redmond/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png",
     "public/stylesheets/jquery/redmond/images/ui-bg_inset-hard_100_f5f8f9_1x100.png",
     "public/stylesheets/jquery/redmond/images/ui-bg_inset-hard_100_fcfdfd_1x100.png",
     "public/stylesheets/jquery/redmond/images/ui-icons_217bc0_256x240.png",
     "public/stylesheets/jquery/redmond/images/ui-icons_2e83ff_256x240.png",
     "public/stylesheets/jquery/redmond/images/ui-icons_469bdd_256x240.png",
     "public/stylesheets/jquery/redmond/images/ui-icons_6da8d5_256x240.png",
     "public/stylesheets/jquery/redmond/images/ui-icons_cd0a0a_256x240.png",
     "public/stylesheets/jquery/redmond/images/ui-icons_d8e7f3_256x240.png",
     "public/stylesheets/jquery/redmond/images/ui-icons_f9bd01_256x240.png",
     "public/stylesheets/jquery/redmond/jquery-ui-1.7.1.custom.css",
     "public/stylesheets/jquery/smoothness/images/ui-bg_flat_0_aaaaaa_40x100.png",
     "public/stylesheets/jquery/smoothness/images/ui-bg_flat_75_ffffff_40x100.png",
     "public/stylesheets/jquery/smoothness/images/ui-bg_glass_55_fbf9ee_1x400.png",
     "public/stylesheets/jquery/smoothness/images/ui-bg_glass_65_ffffff_1x400.png",
     "public/stylesheets/jquery/smoothness/images/ui-bg_glass_75_dadada_1x400.png",
     "public/stylesheets/jquery/smoothness/images/ui-bg_glass_75_e6e6e6_1x400.png",
     "public/stylesheets/jquery/smoothness/images/ui-bg_glass_95_fef1ec_1x400.png",
     "public/stylesheets/jquery/smoothness/images/ui-bg_highlight-soft_75_cccccc_1x100.png",
     "public/stylesheets/jquery/smoothness/images/ui-icons_222222_256x240.png",
     "public/stylesheets/jquery/smoothness/images/ui-icons_2e83ff_256x240.png",
     "public/stylesheets/jquery/smoothness/images/ui-icons_454545_256x240.png",
     "public/stylesheets/jquery/smoothness/images/ui-icons_888888_256x240.png",
     "public/stylesheets/jquery/smoothness/images/ui-icons_cd0a0a_256x240.png",
     "public/stylesheets/jquery/smoothness/jquery-ui-1.7.1.custom.css",
     "public/stylesheets/jquery/ui-lightness/images/ui-bg_diagonals-thick_18_b81900_40x40.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-bg_diagonals-thick_20_666666_40x40.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-bg_flat_10_000000_40x100.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-bg_glass_100_f6f6f6_1x400.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-bg_glass_100_fdf5ce_1x400.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-bg_glass_65_ffffff_1x400.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-bg_gloss-wave_35_f6a828_500x100.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-bg_highlight-soft_100_eeeeee_1x100.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-bg_highlight-soft_75_ffe45c_1x100.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-icons_222222_256x240.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-icons_228ef1_256x240.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-icons_ef8c08_256x240.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-icons_ffd27a_256x240.png",
     "public/stylesheets/jquery/ui-lightness/images/ui-icons_ffffff_256x240.png",
     "public/stylesheets/jquery/ui-lightness/jquery-ui-1.7.1.custom.css",
     "public/stylesheets/reset.css",
     "public/stylesheets/styles.css",
     "rails/init.rb",
     "rails/init.rb",
     "rails_i18n/ar.yml",
     "rails_i18n/bg.yml",
     "rails_i18n/bn-IN.yml",
     "rails_i18n/bs.yml",
     "rails_i18n/ca-ES.yml",
     "rails_i18n/cz.rb",
     "rails_i18n/da.yml",
     "rails_i18n/de-AT.yml",
     "rails_i18n/de.yml",
     "rails_i18n/el.yml",
     "rails_i18n/es-AR.yml",
     "rails_i18n/es-MX.yml",
     "rails_i18n/es.yml",
     "rails_i18n/et.yml",
     "rails_i18n/fa.yml",
     "rails_i18n/fi.yml",
     "rails_i18n/fr-CH.yml",
     "rails_i18n/fr.yml",
     "rails_i18n/gl-ES.yml",
     "rails_i18n/he.yml",
     "rails_i18n/hu.yml",
     "rails_i18n/id.yml",
     "rails_i18n/is.yml",
     "rails_i18n/it.yml",
     "rails_i18n/ja.yml",
     "rails_i18n/ko.yml",
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
     "rails_i18n/rm.yml",
     "rails_i18n/ro.yml",
     "rails_i18n/ru.yml",
     "rails_i18n/sk.yml",
     "rails_i18n/sr-Latn.yml",
     "rails_i18n/sr.yml",
     "rails_i18n/sv-SE.yml",
     "rails_i18n/sw.yml",
     "rails_i18n/th.rb",
     "rails_i18n/tr.yml",
     "rails_i18n/uk.yml",
     "rails_i18n/vi.yml",
     "rails_i18n/zh-CN.yml",
     "rails_i18n/zh-TW.yml",
     "tasks/languages.txt",
     "tasks/languages.txt",
     "tasks/rails.rake",
     "tasks/rails.rake",
     "test/rails_root/.gitignore",
     "test/rails_root/.rake_tasks",
     "test/rails_root/Rakefile",
     "test/rails_root/app/controllers/admin/default_controller.rb",
     "test/rails_root/app/controllers/application_controller.rb",
     "test/rails_root/app/controllers/default_controller.rb",
     "test/rails_root/app/helpers/application_helper.rb",
     "test/rails_root/app/models/.keep",
     "test/rails_root/app/views/admin/default/index.html.erb",
     "test/rails_root/app/views/default/index.html.erb",
     "test/rails_root/app/views/layouts/default.html.erb",
     "test/rails_root/config/amazon_s3.yml",
     "test/rails_root/config/boot.rb",
     "test/rails_root/config/database.yml",
     "test/rails_root/config/environment.rb",
     "test/rails_root/config/environments/development.rb",
     "test/rails_root/config/environments/production.rb",
     "test/rails_root/config/environments/test.rb",
     "test/rails_root/config/global_config.yml",
     "test/rails_root/config/initializers/inflections.rb",
     "test/rails_root/config/initializers/mime_types.rb",
     "test/rails_root/config/initializers/requires.rb",
     "test/rails_root/config/initializers/session_store.rb",
     "test/rails_root/config/routes.rb",
     "test/rails_root/db/.keep",
     "test/rails_root/db/migrate/20090320174818_create_muck_permissions_and_roles.rb",
     "test/rails_root/db/migrate/20090402234137_create_languages.rb",
     "test/rails_root/db/migrate/20090426041056_create_countries.rb",
     "test/rails_root/db/migrate/20090426041103_create_states.rb",
     "test/rails_root/db/migrate/20090602041838_create_users.rb",
     "test/rails_root/features/step_definitions/webrat_steps.rb",
     "test/rails_root/features/support/env.rb",
     "test/rails_root/public/.htaccess",
     "test/rails_root/public/404.html",
     "test/rails_root/public/422.html",
     "test/rails_root/public/500.html",
     "test/rails_root/public/dispatch.rb",
     "test/rails_root/public/favicon.ico",
     "test/rails_root/public/images/arrow_left.gif",
     "test/rails_root/public/images/arrow_right.gif",
     "test/rails_root/public/images/blue/preview.gif",
     "test/rails_root/public/images/icons/accept.png",
     "test/rails_root/public/images/icons/add.png",
     "test/rails_root/public/images/icons/delete.png",
     "test/rails_root/public/images/icons/vote.png",
     "test/rails_root/public/images/loading.gif",
     "test/rails_root/public/images/profile_default.jpg",
     "test/rails_root/public/images/rails.png",
     "test/rails_root/public/images/red/preview.gif",
     "test/rails_root/public/images/spinner.gif",
     "test/rails_root/public/images/sprites.png",
     "test/rails_root/public/javascripts/application.js",
     "test/rails_root/public/javascripts/builder.js",
     "test/rails_root/public/javascripts/controls.js",
     "test/rails_root/public/javascripts/dragdrop.js",
     "test/rails_root/public/javascripts/effects.js",
     "test/rails_root/public/javascripts/fancyzoom.min.js",
     "test/rails_root/public/javascripts/jquery/jquery-ui.js",
     "test/rails_root/public/javascripts/jquery/jquery.form.js",
     "test/rails_root/public/javascripts/jquery/jquery.jgrowl.js",
     "test/rails_root/public/javascripts/jquery/jquery.js",
     "test/rails_root/public/javascripts/jquery/jquery.tips.js",
     "test/rails_root/public/javascripts/muck.js",
     "test/rails_root/public/javascripts/muck_activities.js",
     "test/rails_root/public/javascripts/prototype.js",
     "test/rails_root/public/javascripts/scriptaculous.js",
     "test/rails_root/public/javascripts/slider.js",
     "test/rails_root/public/javascripts/sound.js",
     "test/rails_root/public/robots.txt",
     "test/rails_root/public/stylesheets/.keep",
     "test/rails_root/public/stylesheets/admin.css",
     "test/rails_root/public/stylesheets/blueprint/ie.css",
     "test/rails_root/public/stylesheets/blueprint/liquid_screen.css",
     "test/rails_root/public/stylesheets/blueprint/plugins/buttons/icons/cross.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/buttons/icons/key.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/buttons/icons/tick.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/buttons/readme.txt",
     "test/rails_root/public/stylesheets/blueprint/plugins/buttons/screen.css",
     "test/rails_root/public/stylesheets/blueprint/plugins/fancy-type/readme.txt",
     "test/rails_root/public/stylesheets/blueprint/plugins/fancy-type/screen.css",
     "test/rails_root/public/stylesheets/blueprint/plugins/link-icons/icons/doc.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/link-icons/icons/email.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/link-icons/icons/external.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/link-icons/icons/feed.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/link-icons/icons/im.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/link-icons/icons/pdf.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/link-icons/icons/visited.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/link-icons/icons/xls.png",
     "test/rails_root/public/stylesheets/blueprint/plugins/link-icons/readme.txt",
     "test/rails_root/public/stylesheets/blueprint/plugins/link-icons/screen.css",
     "test/rails_root/public/stylesheets/blueprint/plugins/liquid/liquid.css",
     "test/rails_root/public/stylesheets/blueprint/plugins/liquid/src/liquid.css",
     "test/rails_root/public/stylesheets/blueprint/plugins/rtl/readme.txt",
     "test/rails_root/public/stylesheets/blueprint/plugins/rtl/screen.css",
     "test/rails_root/public/stylesheets/blueprint/print.css",
     "test/rails_root/public/stylesheets/blueprint/screen.css",
     "test/rails_root/public/stylesheets/blueprint/sprite.css",
     "test/rails_root/public/stylesheets/blueprint/src/forms.css",
     "test/rails_root/public/stylesheets/blueprint/src/grid.css",
     "test/rails_root/public/stylesheets/blueprint/src/grid.png",
     "test/rails_root/public/stylesheets/blueprint/src/ie.css",
     "test/rails_root/public/stylesheets/blueprint/src/print.css",
     "test/rails_root/public/stylesheets/blueprint/src/reset.css",
     "test/rails_root/public/stylesheets/blueprint/src/typography.css",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-bg_diagonals-small_0_aaaaaa_40x40.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-bg_diagonals-thick_15_444444_40x40.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-bg_glass_100_f0f0f0_1x400.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-bg_glass_50_99c2ff_1x400.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-bg_glass_55_fbf5d0_1x400.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-bg_glass_80_e6e6e6_1x400.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-bg_glass_95_fef1ec_1x400.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-bg_highlight-hard_100_f9f9f9_1x100.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-bg_highlight-soft_100_e7eef3_1x100.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-icons_222222_256x240.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-icons_2694e8_256x240.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-icons_2e83ff_256x240.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-icons_72a7cf_256x240.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-icons_888888_256x240.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-icons_cd0a0a_256x240.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/images/ui-icons_ffffff_256x240.png",
     "test/rails_root/public/stylesheets/jquery/cupertino/jquery-ui-1.7.1.custom.css",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-bg_flat_0_aaaaaa_40x100.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-bg_flat_55_fbec88_40x100.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-bg_glass_75_d0e5f5_1x400.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-bg_glass_85_dfeffc_1x400.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-bg_glass_95_fef1ec_1x400.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-bg_inset-hard_100_f5f8f9_1x100.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-bg_inset-hard_100_fcfdfd_1x100.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-icons_217bc0_256x240.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-icons_2e83ff_256x240.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-icons_469bdd_256x240.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-icons_6da8d5_256x240.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-icons_cd0a0a_256x240.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-icons_d8e7f3_256x240.png",
     "test/rails_root/public/stylesheets/jquery/redmond/images/ui-icons_f9bd01_256x240.png",
     "test/rails_root/public/stylesheets/jquery/redmond/jquery-ui-1.7.1.custom.css",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-bg_flat_0_aaaaaa_40x100.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-bg_flat_75_ffffff_40x100.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-bg_glass_55_fbf9ee_1x400.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-bg_glass_65_ffffff_1x400.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-bg_glass_75_dadada_1x400.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-bg_glass_75_e6e6e6_1x400.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-bg_glass_95_fef1ec_1x400.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-bg_highlight-soft_75_cccccc_1x100.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-icons_222222_256x240.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-icons_2e83ff_256x240.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-icons_454545_256x240.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-icons_888888_256x240.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/images/ui-icons_cd0a0a_256x240.png",
     "test/rails_root/public/stylesheets/jquery/smoothness/jquery-ui-1.7.1.custom.css",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-bg_diagonals-thick_18_b81900_40x40.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-bg_diagonals-thick_20_666666_40x40.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-bg_flat_10_000000_40x100.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-bg_glass_100_f6f6f6_1x400.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-bg_glass_100_fdf5ce_1x400.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-bg_glass_65_ffffff_1x400.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-bg_gloss-wave_35_f6a828_500x100.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-bg_highlight-soft_100_eeeeee_1x100.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-bg_highlight-soft_75_ffe45c_1x100.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-icons_222222_256x240.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-icons_228ef1_256x240.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-icons_ef8c08_256x240.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-icons_ffd27a_256x240.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/images/ui-icons_ffffff_256x240.png",
     "test/rails_root/public/stylesheets/jquery/ui-lightness/jquery-ui-1.7.1.custom.css",
     "test/rails_root/public/stylesheets/reset.css",
     "test/rails_root/public/stylesheets/styles.css",
     "test/rails_root/public/stylesheets/themes/blue/styles.css",
     "test/rails_root/public/stylesheets/themes/red/styles.css",
     "test/rails_root/script/about",
     "test/rails_root/script/breakpointer",
     "test/rails_root/script/console",
     "test/rails_root/script/create_project.rb",
     "test/rails_root/script/cucumber",
     "test/rails_root/script/dbconsole",
     "test/rails_root/script/destroy",
     "test/rails_root/script/generate",
     "test/rails_root/script/performance/benchmarker",
     "test/rails_root/script/performance/profiler",
     "test/rails_root/script/performance/request",
     "test/rails_root/script/plugin",
     "test/rails_root/script/process/inspector",
     "test/rails_root/script/process/reaper",
     "test/rails_root/script/process/spawner",
     "test/rails_root/script/runner",
     "test/rails_root/script/server",
     "test/rails_root/test/functional/.keep",
     "test/rails_root/test/functional/admin/default_controller_test.rb",
     "test/rails_root/test/functional/default_controller_test.rb",
     "test/rails_root/test/integration/.keep",
     "test/rails_root/test/mocks/development/.keep",
     "test/rails_root/test/mocks/test/.keep",
     "test/rails_root/test/test_helper.rb",
     "test/rails_root/test/unit/.keep",
     "test/rails_root/test/unit/basic_mailer_test.rb",
     "test/rails_root/test/unit/muck_engine_helper_test.rb",
     "test/rails_root/vendor/plugins/ssl_requirement/README",
     "test/rails_root/vendor/plugins/ssl_requirement/lib/ssl_requirement.rb",
     "test/rails_root/vendor/plugins/ssl_requirement/test/ssl_requirement_test.rb",
     "uninstall.rb"
  ]
  s.homepage = %q{http://github.com/tatemae/muck_engine}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{muck-engine}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{The base engine for the muck system.}
  s.test_files = [
    "test/rails_root/app/controllers/admin/default_controller.rb",
     "test/rails_root/app/controllers/application_controller.rb",
     "test/rails_root/app/controllers/default_controller.rb",
     "test/rails_root/app/helpers/application_helper.rb",
     "test/rails_root/config/boot.rb",
     "test/rails_root/config/environment.rb",
     "test/rails_root/config/environments/development.rb",
     "test/rails_root/config/environments/production.rb",
     "test/rails_root/config/environments/test.rb",
     "test/rails_root/config/initializers/inflections.rb",
     "test/rails_root/config/initializers/mime_types.rb",
     "test/rails_root/config/initializers/requires.rb",
     "test/rails_root/config/initializers/session_store.rb",
     "test/rails_root/config/routes.rb",
     "test/rails_root/db/migrate/20090320174818_create_muck_permissions_and_roles.rb",
     "test/rails_root/db/migrate/20090402234137_create_languages.rb",
     "test/rails_root/db/migrate/20090426041056_create_countries.rb",
     "test/rails_root/db/migrate/20090426041103_create_states.rb",
     "test/rails_root/db/migrate/20090602041838_create_users.rb",
     "test/rails_root/features/step_definitions/webrat_steps.rb",
     "test/rails_root/features/support/env.rb",
     "test/rails_root/public/dispatch.rb",
     "test/rails_root/script/create_project.rb",
     "test/rails_root/test/functional/admin/default_controller_test.rb",
     "test/rails_root/test/functional/default_controller_test.rb",
     "test/rails_root/test/test_helper.rb",
     "test/rails_root/test/unit/basic_mailer_test.rb",
     "test/rails_root/test/unit/muck_engine_helper_test.rb",
     "test/rails_root/vendor/plugins/ssl_requirement/lib/ssl_requirement.rb",
     "test/rails_root/vendor/plugins/ssl_requirement/test/ssl_requirement_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<validation_reflection>, [">= 0"])
      s.add_runtime_dependency(%q<will_paginate>, [">= 0"])
      s.add_runtime_dependency(%q<git>, [">= 0"])
    else
      s.add_dependency(%q<validation_reflection>, [">= 0"])
      s.add_dependency(%q<will_paginate>, [">= 0"])
      s.add_dependency(%q<git>, [">= 0"])
    end
  else
    s.add_dependency(%q<validation_reflection>, [">= 0"])
    s.add_dependency(%q<will_paginate>, [">= 0"])
    s.add_dependency(%q<git>, [">= 0"])
  end
end
