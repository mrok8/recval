class TopicsController < ApplicationController
  add_breadcrumb 'トップ',:root_path
  def index
    @new_topics = Topic.where(published_flg: true).order("created_at DESC")
  end

  def show
    @topic = Topic.find(params[:id])
    @products = Product.where(topic_id: @topic.id,status: 1).order("created_at ASC")
    @recommenders = Recommender.where()
    @same_category_topics =Topic.where(category_id: @topic.category_id).where.not(id: @topic.id).limit(4)
    add_breadcrumb "#{@topic.need.name}","/needs/#{@topic.need_id}"
    add_breadcrumb "#{@topic.category.name}","/categories/#{@topic.category_id}"
    add_breadcrumb @topic.title
  end

  private
  def topic_params
    params.require(:topic).permit(:title,:name,:text)
  end
end
