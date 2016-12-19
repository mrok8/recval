class TopicsController < ApplicationController
  add_breadcrumb 'トップ',:root_path
  def index
    @new_topics = Topic.where(published_flg: true).order("created_at DESC").limit(4)
    needs = Need.all
    categories = Category.all
    @recommend_needs = needs.limit(6)
    @recommend_categories = categories.limit(6)
    @need_name = []
    @category_name = []
    @new_topics.each do |t|
      @need_name << needs[t.need_id-1].name
      @category_name << categories[t.category_id-1].name
    end
  end

  def show
    @topic = Topic.find(params[:id])
    category = Category.find(@topic.category_id)
    @category_name = category.name
    @need_name = Need.find(@topic.need_id).name
    @same_category_topics =Topic.where(category_id: category.id).limit(4)
    add_breadcrumb "#{@need_name}","/needs/#{@topic.need_id}"
    add_breadcrumb "#{@category_name}","/categories/#{@topic.category_id}"
    add_breadcrumb @topic.title
  end

  private
  def topic_params
    params.require(:topic).permit(:title,:name,:text)
  end
end
