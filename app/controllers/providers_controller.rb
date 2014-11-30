class ProvidersController < ApplicationController
  def index
    feelings = params[:feelings].map{|word| Feeling.find_by(word: word)}
    # locations = Location.near(params[:location], params[:distance])
    locations = Location.near(60606.to_s, 1)
    assessments = Assessment.determine_prevalent(feelings)
    # @secondary_feelings = Feeling.select(2, assessments) #unless feelings.any?{|feel| feel.ranking >= 2}
    # @tertiary_feelings = Feeling.select(3, assessments) #unless feelings.all?{|feel| feel.ranking == 1}
    @feelings = assessments.map{|a| a.secondary_feelings}.flatten.uniq
    # @tertiary_feelings = assessments.map{|a| a.tertiary_feelings}.flatten.uniq
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

  #need to create competency specialties still
  #also locations
  def create
    competencies = {}
    competencies[:depression] = params[:provider].delete("depression")
    competencies[:anxiety] = params[:provider].delete("anxiety")
    competencies[:adhd] = params[:provider].delete("adhd")
    competencies[:addiction] = params[:provider].delete("addiction")
    competencies[:eating_disorders] = params[:provider].delete("eating_disorders")
    competencies[:grief] = params[:provider].delete("grief")
    selected_competencies = competencies.select {|k,v| v.to_i == 1}.keys
    params
    binding.pry
    #create the competencies entries
    params[:provider].delete("competency")
    location = params[:provider][:zip_code].to_i
    #create the location entry
    #remove the location key from the provider hash
    @provider = Provider.new(provider_params)
    if @provider.save
      selected_competencies.each do |competency|
        Competency.create!(provider: @provider, assessment: Assessment.find_by(word: competency.to_s))
      end
      Residence.create!(provider: @provider, location: Location.find_by(zip_code: location))
      binding.pry
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
