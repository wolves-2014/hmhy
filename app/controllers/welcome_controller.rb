class WelcomeController < ApplicationController
  def index
    @feelings = Feeling.where(ranking: 1)
  end
end
