class FeelingsController < ApplicationController
  def index
    @primary_feelings = Feeling.where(ranking: 1) #should not be all
    @secondary_feelings = Feeling.where(ranking: 2) #should not be all
    @tertiary_feelings = Feeling.where(ranking: 3) #should not be all
  end

  def show
  end

  def create
  end
end
