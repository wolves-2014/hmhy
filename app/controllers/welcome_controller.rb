class WelcomeController < ApplicationController
  def index
    @feelings = Feeling.top_level_feelings
  end

end
