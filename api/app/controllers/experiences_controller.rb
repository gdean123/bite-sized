class ExperiencesController < ApplicationController
  respond_to :json

  def index
    respond_with Experience.all
  end

end
