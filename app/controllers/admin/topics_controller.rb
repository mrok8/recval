class Admin::TopicsController < ApplicationController
   before_action :sign_in_required_admin, only: [:index,:new,:edit,:new]
   require 'date'

  def index
    @topics = Topic.all
    needs = Need.all
    @wait_products = Product.where(status: [0,2])
    categories = Category.all
    @need_name = []
    @category_name = []
    @topics.each do |t|
      @need_name << needs[t.need_id-1].name
      @category_name << categories[t.category_id-1].name
    end
    @wait_topics = []
    @wait_products.each do |p|
      @wait_topics << Topic.where(category_id: p.category_id, need_id: p.need_id)[0].id
    end
  end

  def new
    @topic = Topic.new
  end

  def create
    topic = Topic.new(title: params[:topic][:title], text: params[:topic][:text],thumb_url: params[:topic][:thumb_url],category_id: params[:topic][:category_id],need_id: params[:topic][:need_id],description: params[:topic][:description])
    topic[:created_at] =  DateTime.now
    topic[:updated_at] =  DateTime.now
    topic[:published_flg] = true
    if topic.save
      redirect_to topic_show_path(topic.id)
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    @products = Product.where(category_id: @topic.category_id,need_id: @topic.need_id,status: [0,2])
  end

  def save
    topic = Topic.find(params[:id])
    topic.title = params[:topic][:title]
    topic.description = params[:topic][:description]
    topic.text = params[:topic][:text]
    topic.thumb_url = params[:topic][:thumb_url]
    topic.category_id = params[:topic][:category_id]
    topic.need_id = params[:topic][:need_id]
    topic.updated_at =  DateTime.now
    if topic.save
      redirect_to topic_show_path(params[:id])
    end
  end

  def add_image
    topic = Topic.find(params[:topic_id])
    recommender_name = Recommender.find(params[:product][:recommender_id]).name
    text = "

    <h2>"+params[:product][:title]+"</h2>
    <span class='recommender-label'>"+recommender_name+"オススメ商品</span>
    <div style='width: 100%'>
      <div class='row-img'>
        <img src="+params[:product][:image_url]+" class='topic-img'></div>
      <div class='row-right'>
        <h3>"+recommender_name+"さんのオススメポイント</h4>
        <ul>
          <li>"+params[:product][:recommend_point_1]+"</li>
          <li>"+params[:product][:recommend_point_2]+"</li>
          <li>"+params[:product][:recommend_point_3]+"</li>
        </ul>
      </div>
    </div>
    <h3>"+recommender_name+"さんの総評・体験談</h4>
    <div>"+params[:product][:text].to_s+"</div>
    <div class='buttom-div'>
      <div class='buttom'>
        <a href="+params[:product][:site_url]+" style='color: #59A2F5;' target='_blank'>商品ページへ</a>
      </div>
    </div>

    <blockquote>"+params[:product][:information].gsub(/\r\n|\r|\n/, '<br />')+"
      <br>
      <a href="+params[:product][:site_url]+" target='_blank' class='no-decoration'>
        <cite class='citation-url'>出典："+params[:product][:site_url]+"</cite>
      </a>
    </blockquote>"
    topic.text = topic.text + text
    product = Product.find(params[:product][:product_id])
    product.status = 1
    if topic.save && product.save
      redirect_to :back
    end
  end

end