class ProviderMailer < ActionMailer::Base
  default from: "admin@beacon.com"

  def welcome_email(provider)
    @provider = provider
    mail(to: @provider.email, subject: 'Welcome to Beacon')
  end

  def contact_email(contact_information)
    @client_name = contact_information[:client_name]
    @client_email = contact_information[:client_email]
    @provider = contact_information[:provider]
    @message = contact_information[:message]
    mail(to: @provider.email, subject: 'Someone needs your help')
  end

  def reply(params)
    @message = params[:message]
    @subject = params[:subject]
    @to = params[:to]
    mail(to: @to, subject: @subject, message: @message)
  end
end
