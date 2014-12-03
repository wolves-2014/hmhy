class WelcomeController < ApplicationController
  def index
    @feelings = Feeling.where(rank: 1)
  end

  def about

  end
end
