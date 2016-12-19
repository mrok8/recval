class NeedsController < ApplicationController
  def index
    @need_topics = Topic.where(need_id: params[:id])
    @need = Need.find(params[:id])
  end
end
