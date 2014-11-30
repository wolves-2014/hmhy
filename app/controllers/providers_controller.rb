class ProvidersController < ApplicationController
  def index
    # binding.pry
    feelings = params[:feelings].map{|word| Feeling.find_by(word: word)}
    # locations = Location.near(params[:location], params[:distance])
    locations = Location.near(60606.to_s, 1)
    assessments = Assessment.determine_prevalent(feelings)
    @feelings = Feeling.next_step(feelings.first.ranking + 1, assessments) if feelings.all?{|feel| feel.ranking < 3}
    @providers = Provider.match(assessments, locations)
    respond_to do |format|
      format.json {
        render json: {providers_html: render_to_string("index.html.erb", locals: {providers: @providers}, layout: false),
          feelings_html: render_to_string("feelings/secondary_index", locals: {feelings: @feelings}, layout: false)}
      }
    end
  end
end
