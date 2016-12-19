class Admin::NeedsController < ApplicationController
  before_action :sign_in_required_admin, only: [:index]
  def index
    @need = Need.new
    @needs = Need.all
  end

  def create
    new_need = Need.new(name: params[:need][:name], thumb_url: params[:need][:thumb_url])
    if new_need.save
      redirect_to :back
    end
  end
end
