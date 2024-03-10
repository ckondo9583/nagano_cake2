class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

 
 
  def index
    @cart_items = CartItem.all
    # @cart_items = current_customer.cart_items
  end
  
  
  def create
   @cart_item = current_customer.cart_items.new(cart_item_params)
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
