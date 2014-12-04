class ProvidersController < ApplicationController
  include LocationsHelper

  def index
    feelings = params[:feelings] || session[:feelings]
    session[:feelings] = feelings
    search = if params[:refine_search]
      ProviderSearch.new(feelings, params[:refine_search])
    else
      ProviderSearch.new(feelings)
    end

    if session[:location_id]
      if search.zip_code
        @location = search.location_from_zip_code
      else
        @location = Location.find(session[:location_id])
        search.location = @location
      end
    else
      search.zip_code = Location.find_zip_code_by_location_data(location_data)
      @location = search.location_from_zip_code
    end
    session[:location_id] = @location.id

    @feelings = search.related_feelings
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
        ProviderMailer.welcome_email(@provider).deliver
        competencies.each do |competency|
          assessment = Assessment.find_by(word: competency)
          @provider.competencies.create(assessment: assessment)
        end
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

end
