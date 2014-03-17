class ExperiencesController < ApplicationController
  respond_to :json

  def create
    experience = Experience.create(params.permit(:tagline))
    respond_with experience
  end

  def show
  end

  def index
    respond_with Experience.all
  end

  def destroy
    experience = Experience.find(params[:id])
    respond_with experience.destroy
  end

end
