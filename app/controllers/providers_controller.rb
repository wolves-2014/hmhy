class ProvidersController < ApplicationController
  def loc_data
    # To avoid 0/0 lat/long from geocoding 127.0.0.1
    if Rails.env.development?
      Location.default_development_location
    else
      request.location
    end
  end

  def index
    feelings = params[:feelings].map{|word| Feeling.find_by(word: word)}
    if session[:location_id]
      @location = Location.find(session[:location_id])
    else
      raise request.location.inspect

      @location = Location.find_or_create_by_loc_data(loc_data)
      session[:location_id] = @location.id
    end
    params[:distance] ? distance = params[:distance] : distance = 2
    locations = @location.nearbys(distance)
    assessments = Assessment.determine_prevalent(feelings)
    @feelings = assessments.map{|a| a.secondary_feelings}.flatten.uniq if feelings.first.ranking == 1
    @feelings = assessments.map{|a| a.tertiary_feelings}.flatten.uniq if feelings.first.ranking == 2

    @providers = Provider.match(assessments, locations)

    respond_to do |format|
      format.json {
        render json: {providers_html: render_to_string("index.html.erb", layout: false),
          feelings_html: render_to_string("feelings/_index.html.erb", layout: false)
        }
      }
    end
  end

  def new
  end

  def create
    competencies = params[:competency][0].keys
    zip_code = params[:provider][:zip_code].to_i
    location = Location.find_or_create_by(zip_code: zip_code)
    @provider = location.providers.new(provider_params)
    binding.pry
    if @provider.save
      binding.pry
      ProviderMailer.welcome_email(@provider).deliver
      competencies.each do |competency|
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
