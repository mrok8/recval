class Admin::CategoriesController < ApplicationController
  before_action :sign_in_required_admin, only: [:index]
  def index
    @category =Category.new
    @categories = Category.all
  end

  def create
    new_category = Category.new(name: params[:category][:name],thumb_url: params[:category][:thumb_url],parent_id: params[:category][:parent_id])
    if new_category.save
      redirect_to :back
    end
  end
end
