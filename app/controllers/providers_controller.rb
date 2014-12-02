class ProvidersController < ApplicationController
  include LocationsHelper

  def index
    @location = if session[:location_id]
      Location.find(session[:location_id])
    else
      Location.find_or_create_by_location_data(location_data)
    end
    session[:location_id] = @location.id

    # location_data = Geocoder.search(params[:location][:zip_code]).first
    # @location = Location.find_or_create_by(zip_code: location_data.postal_code)
    # session[:location_id] = @location.id
    feelings = Feeling.find_by_word(params[:feelings])
    assessments = Assessment.determine_prevalent(feelings)
    @feelings = assessments.map{|a| a.feelings_by_rank(feelings.first.rank)}.flatten.uniq
    locations = @location.find_within(params[:distance])
    @providers = MatchMaker.new(assessments, locations).matches
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
    location = Location.find_or_create_by(zip_code: params[:provider][:zip_code].to_i)
    competencies = params[:competency][0].keys
    @provider = location.providers.new(provider_params)
    if @provider.save
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
