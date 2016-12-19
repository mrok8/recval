class TopsController < ApplicationController
  def index
    @new_topics = Topic.where(published_flg: true).order("created_at DESC").limit(5)
    needs = Need.all
    categories = Category.all
    @recommend_needs = needs.limit(11)
    @recommend_categories = categories.limit(11)
    @need_name = []
    @category_name = []
    @new_topics.each do |t|
      @need_name << needs[t.need_id-1].name
      @category_name << categories[t.category_id-1].name
    end
  end
end
