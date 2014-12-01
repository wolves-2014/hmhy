class ProviderMailer < ActionMailer::Base
  default from: "admin@spring.com"

  def welcome_email(provider)
    @provider = provider
    mail(to: @provider.email, subject: 'Welcome to Spring')
  end

  def contact_email(contact_information)
    @client_name = contact_information[:client_name]
    @client_email = contact_information[:client_email]
    @provider = contact_information[:provider]
    @message = contact_information[:message]
    mail(to: @provider.email, subject: 'Someone needs your help')
  end
end
