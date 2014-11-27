class ProvidersController < ApplicationController
  def index
    feelings = params[:feeling_ids].map {|id| Feeling.find(id)}
    assessments = Assessment.determine_prevalent(feelings)
    @providers = Provider.match(assessments)
  end
end
