class TopsController < ApplicationController
  def index
    @new_topics = Topic.where(published_flg: true).order("created_at DESC").limit(5)
    @recommend_needs = Need.all
    @recommend_categories = Category.all
  end
end
