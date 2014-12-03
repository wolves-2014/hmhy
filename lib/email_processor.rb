class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    #save a copy in our database for protection
    params = {}
    params[:message] = @email.raw_text
    params[:subject] = @email.subject
    params[:to] = @email.to[0][:email]

    ProviderMailer.reply(params).deliver

    # all of your application-specific code here - creating models,
    # processing reports, etc

    # here's an example of model creation
    Rails.logger.info("I'm in the Email Processer class...")
    # user = User.find_by_email(@email.from[:email])
    # user.posts.create!(
    #   subject: @email.subject,
    #   body: @email.body
    # )
  end
end

# curl -X POST http://localhost:3000/email_processor -d @sample_mandrill_email.json
