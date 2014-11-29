class ProvidersController < ApplicationController
  def index
    # feelings = params[:feelings].map{|word| Feeling.find_by(word: feeling)}
    feelings = [Feeling.find_by(word: params[:feeling])]
    # locations = Location.near(params[:location], params[:distance])
    locations = Location.near(60606.to_s, 1)
    assessments = Assessment.determine_prevalent(feelings)
    # assessments = Indication.assess(feelings)
    @providers = Provider.match(assessments, locations)
    respond_to do |format|
      format.json {
        render json: {html: render_to_string(:template => "providers/index.html.erb", :locals => {:providers => @providers}, layout: false) }
      }
    end
  end
end
