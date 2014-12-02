class WelcomeController < ApplicationController
  def index
    @feelings = Feeling.where(rank: 1)
  end
end
