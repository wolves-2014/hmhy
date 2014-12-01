class WelcomeController < ApplicationController
  def index
    binding.pry
    @feelings = Feeling.where(ranking: 1)
  end
end
