class ProviderMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(provider)
    @provider = provider
    @url  = 'http://example.com/login'
    mail(to: @provider.email, subject: 'Welcome to Spring')
  end

  def contact_email(provider, client_name, client_email)
    @client_name = client_name
    @client_email = client_email
    @provider = provider
    @url  = 'http://example.com/login'
    mail(to: @provider.email, subject: 'Someone needs your help')
  end
end
