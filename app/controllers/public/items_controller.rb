class Public::ItemsController < ApplicationController
 
  def index
    @items = Item.all
  end
  
   def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
   end

   def create
      @cart_item = current_customer.cart_items.build(cart_item_params)
       if @cart_item.save
         # カートアイテムの追加成功時の処理
         redirect_to cart_items_path, notice: "カートに商品を追加しました。"
       else
         # カートアイテムの追加失敗時の処理
         redirect_to items_path, alert: "カートに商品を追加できませんでした。"
       end
   end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end


end
