class BasicMailer < ActionMailer::Base

  def mail_from_params(options)
    options[:to] ||= MuckEngine.configuration.support_email
    options[:from] ||= self.class.default_from_email
    mail(options)
  end

end