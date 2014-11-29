class ProvidersController < ApplicationController
  def index
    feelings = []
    feelings << Feeling.find_by(word: params[:feeling])
    # feelings.map {|id| Feeling.find(id)}
    assessments = Assessment.determine_prevalent(feelings)
    @providers = Provider.match(assessments)
    respond_to do |format|
      format.json {
        render json: {html: render_to_string(:template => "providers/index.html.erb", :locals => {:providers => @providers}, layout: false) }
      }
    end
  end
end
