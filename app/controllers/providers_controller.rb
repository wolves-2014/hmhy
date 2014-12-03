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
    highest_rank = highest_rank_of_feelings(feelings)
    @feelings = assessments.map{|assessment| assessment.feelings_by_rank(highest_rank + 1)}.flatten.uniq
    locations = @location.find_within(params[:distance])
    @providers = MatchMaker.new(assessments, locations).matches
    respond_to do |format|
    format.json {
      render json: {providers_html: render_to_string("index.html.erb", layout: false),
        feelings_html: render_to_string("feelings/_index.html.erb", layout: false),
        highest_feeling_rank: highest_rank
      }
    }
    end
  end

  def new
  end

  def create
    #should be more in the Provider Model
    # @provider, result = Provider.register_new_provider(params)
    # case result
    # when :successfully_signed_up ...
    # when :invalid_data_for_provider ...
    # when :invalid_zip_code ...
    zip_code = params[:provider][:zip_code]
    if zip_code.length == 5
      location = Location.find_or_create_by(zip_code: zip_code.to_i)
      competencies = params[:competency][0].keys
      @provider = location.providers.new(provider_params)
      if @provider.save
        competencies.each do |competency|
          assessment = Assessment.find_by(word: competency)
          @provider.competencies.create(assessment: assessment)
        end
        ProviderMailer.welcome_email(@provider).deliver
        flash[:notice] = "You have successfully signed up!!"
        redirect_to root_path
      else
        render "new"
        flash[:notice] = "Oops, something went wrong. Try again."
      end
    else
      render "new"
      flash[:notice] = "Must enter valid use zip code."
    end
  end

private
  def provider_params
    params.require(:provider).permit(:name, :email, :photo_url, :profile_url, :phone_number, :title)
  end
  def highest_rank_of_feelings(feelings)
    feelings.map(&:rank).max
  end
end
