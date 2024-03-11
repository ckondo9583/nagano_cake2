class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!



  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.item.price * cart_item.amount }
    @order = Order.new
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

  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
     redirect_to '/cart_items'
  end
  
  def destroy_all
    Cartitem.destroy_all
    redirect_to '/cart_items'
  end

  def update
     @cart_item = CartItem.find(params[:id])
     @cart_item.update(cart_item_params)
     redirect_to '/cart_items'
  end
  

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
