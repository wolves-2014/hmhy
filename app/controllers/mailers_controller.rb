class MailersController < ApplicationController
  def create
    contact_information = {
      provider: Provider.find(params[:provider_id]),
      client_email: params[:client_email],
      client_name: params[:client_name],
      message: params[:message]
    }
    ProviderMailer.contact_email(contact_information).deliver
    head 200
  end
end
