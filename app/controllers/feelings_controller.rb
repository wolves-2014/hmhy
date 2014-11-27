class FeelingsController < ApplicationController
  def index
    @feelings = Feeling.all #should not be all
  end
end
