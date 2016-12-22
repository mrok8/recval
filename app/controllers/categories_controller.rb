class CategoriesController < ApplicationController
  def index
    @parent_category = Category.find(params[:id])
    parent_categories = Category.where(parent_id: params[:id])
    @category_topics = Topic.where(category_id: parent_categories)
  end
end
