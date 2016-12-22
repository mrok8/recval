class Admin::TopicsController < ApplicationController
   before_action :sign_in_required_admin, only: [:index,:new,:edit,:new]
   require 'date'

  def index
    @topics = Topic.all
    @wait_products = Product.where(status: [0,2])
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
    @products = Product.where(topic_id: @topic.id,status: [0,2])
  end

  def save
    topic = Topic.find(params[:id])
    topic.title = params[:topic][:title]
    topic.description = params[:topic][:description]
    topic.thumb_url = params[:topic][:thumb_url]
    topic.category_id = params[:topic][:category_id]
    topic.need_id = params[:topic][:need_id]
    topic.updated_at =  DateTime.now
    if topic.save
      redirect_to topic_show_path(params[:id])
    end
  end

  def add_image
    product = Product.find(params[:product][:product_id])
    product.status = 1
    product.updated_at =  DateTime.now
    if  product.save
      redirect_to :back
    end
  end

end