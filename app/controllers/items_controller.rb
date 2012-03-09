class ItemsController < ApplicationController
  def index
  end
  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html{
        render :layout => ! request.xhr?
      }
      format.json {
        render :json => @item, :callback => params[:callback]
      }
    end
  end

  def query
    @items = Item.search params[:keyword]
    respond_to do |format|
      format.html{
        render :layout => ! request.xhr?
      }
      format.json {
        render :json => {:total => @items.total, :items => @items, :as_json => items_query_url(:keyword => params[:keyword], :format => :json) }, :callback => params[:callback]
      }
    end

  end
end
