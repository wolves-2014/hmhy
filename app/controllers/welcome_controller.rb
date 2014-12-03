class WelcomeController < ApplicationController
  def index
    # Feeling.top_level_feelings
    @feelings = Feeling.where(rank: 1)
  end

  def about
    #potentially delete action
  end
end
