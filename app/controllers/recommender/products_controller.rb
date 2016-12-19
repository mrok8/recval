class Recommender::ProductsController < ApplicationController
  before_action :sign_in_required_recommender, only: [:index]
  def index
    @product =Product.new
    @products = Product.where(recommender_id: current_recommender.id)
    @need_name = []
    @category_name = []
    @topic_id = []
    needs = Need.all
    categories = Category.all
    @products.each do |p|
      @topic_id << Topic.where(need_id: p.need_id,category_id: p.category_id)
      @need_name << needs[p.need_id-1].name
      @category_name << categories[p.category_id-1].name
    end
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:product_id])
  end

  def create
    product = Product.new
    product.title = params[:product][:title]
    product.image_url = params[:product][:image_url]
    product.text = params[:product][:text]
    product.recommender_id = current_recommender.id
    product.need_id = params[:product][:need_id]
    product.category_id = params[:product][:category_id]
    product.status = 0
    product.site_url = params[:product][:site_url]
    product.information = params[:product][:information]
    product.quotation = params[:product][:quotation]
    product.recommend_point_1 = params[:product][:recommend_point_1]
    product.recommend_point_2 = params[:product][:recommend_point_2]
    product.recommend_point_3 = params[:product][:recommend_point_3]
    if product.save
      redirect_to :back
    end
  end

  def save
    product = Product.find(params[:product_id])
    product.title = params[:product][:title]
    product.image_url = params[:product][:image_url]
    product.text = params[:product][:text]
    product.status = 2
    product.site_url = params[:product][:site_url]
    product.information = params[:product][:information]
    product.quotation = params[:product][:quotation]
    product.recommend_point_1 = params[:product][:recommend_point_1]
    product.recommend_point_2 = params[:product][:recommend_point_2]
    product.recommend_point_3 = params[:product][:recommend_point_3]
    if product.save
      redirect_to :back
    end
  end
end
