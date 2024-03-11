class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.item.price * cart_item.amount }
    @customer = current_customer
  end

  def comfirm
  end

  def complete
  end

  def create
  end

  def index
  end

  def show
  end
  
   private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
