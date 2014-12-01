class ProviderMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(provider)
    @provider = provider
    @url  = 'http://example.com/login'
    mail(to: @provider.email, subject: 'Welcome to Spring')
  end
end
