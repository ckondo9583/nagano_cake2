class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @items = Item.all
  end

  def create
     @item = Item.new(item_params)
  if @item.save
     redirect_to admin_items_path, notice: '商品が登録されました。'
  else
     render :new
  end
  end
  
  def new
    @item = Item.new
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :price,:introduction)
  end
  
end
