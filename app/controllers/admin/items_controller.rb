class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end
  
  def edit
     @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "successfully."
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end
  

  def create
     @item = Item.new(item_params)
  if @item.save
     redirect_to admin_item_path(@item), notice: '商品が登録されました。'
  else
     render :new
  end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  

  private

  def item_params
    params.require(:item).permit(:name, :price,:introduction)
  end

end
