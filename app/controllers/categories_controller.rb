class CategoriesController < ApplicationController
  def index
    @category_topics = Topic.where(category_id: params[:id])
    @category = Category.find(params[:id])
  end
end
