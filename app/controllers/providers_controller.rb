class ProvidersController < ApplicationController

  def index
    feelings = params[:feelings] || session[:feelings]
    session[:feelings] = feelings
    search = ProviderSearch.new(feelings, params[:refine_search] || {})
    if session[:location_id]
      @location = if search.zip_code
        search.location_from_zip_code
      else
        search.location = Location.find(session[:location_id])
      end
    else
      search.zip_code = Location.find_zip_code_by_location_data(location_data)
      @location = search.location_from_zip_code
    end
    session[:location_id] = @location.id

    @feelings = search.next_ranks_feelings
    # @feelings = search.next_ranks_feelings
    @providers = search.results
    respond_to do |format|
      format.json {
        render json: {providers_html: render_to_string("index.html.erb", layout: false),
          feelings_html: render_to_string("feelings/_index.html.erb", layout: false),
          highest_feeling_rank: search.highest_rank
        }
      }
    end
  end

  def new
  end

  def create
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

  def location_data
    # To avoid 0/0 lat/long from geocoding 127.0.0.1
    # if Rails.env.development?
      Struct.new(:latitude, :longitude).new(41.85, -87.65)
    # else
    #   request.lcation
    # end
  end
end
