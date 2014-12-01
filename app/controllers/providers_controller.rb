class ProvidersController < ApplicationController
  def index
    feelings = params[:feelings].map{|word| Feeling.find_by(word: word)}
    # if params[:location]
    #   locations = Location.near(params[:location], params[:distance])
    # else
    #   locations = Location.near([request.location.latitude, request.location.longitude], 5)
    # end
    location = Location.find_by(zip_code: 60606.to_s)
    locations = location.nearbys(1)
    assessments = Assessment.determine_prevalent(feelings)
    @feelings = assessments.map{|a| a.secondary_feelings}.flatten.uniq if feelings.first.ranking == 1
    @feelings = assessments.map{|a| a.tertiary_feelings}.flatten.uniq if feelings.first.ranking == 2
    # reduce distance, until providers are 3 or distance is 0.5 (or something)
    @providers = Provider.match(assessments, locations)
    # session will keep selected feelings
    respond_to do |format|
      format.json {
        render json: {providers_html: render_to_string("index.html.erb", layout: false),
          feelings_html: render_to_string("feelings/_index.html.erb", layout: false)
          # tertiary_feelings_html: render_to_string("feelings/additional_feelings", locals: {feelings: @tertiary_feelings}, layout: false)
        }
      }
    end
  end

  def new
  end

  def create
    competencies_array = []
    competencies_hash = params[:competency][0]
    competencies_hash.each_key { |key| competencies_array << key }
    zip_code = params[:provider][:zip_code].to_i
    location = Location.find_or_create_by(zip_code: zip_code)
    @provider = location.providers.new(provider_params)
    binding.pry
    if @provider.save
      binding.pry
      ProviderMailer.welcome_email(@provider).deliver
      competencies_array.each do |competency|
        assessment = Assessment.find_by(word: competency)
        @provider.competencies.create(assessment: assessment)
      end
      redirect_to root_path
    else
      render "new"
    end
  end

  private
    def provider_params
      params.require(:provider).permit(:name, :email, :photo_url, :profile_url, :phone_number, :title)
    end
end
