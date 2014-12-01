class ProviderMailer < ActionMailer::Base
  default from: "admin@spring.com"

  def welcome_email(provider)
    @provider = provider
    mail(to: @provider.email, subject: 'Welcome to Spring')
  end

  def contact_email(provider, client_name, client_email)
    @client_name = client_name
    @client_email = client_email
    @provider = provider
    mail(to: @provider.email, subject: 'Someone needs your help')
  end
end
