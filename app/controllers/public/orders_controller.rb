class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def new
    @customer = current_customer
   
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.item.price * cart_item.amount }
    @shipping_fee = 900
    @total_price = @shipping_fee + @total
    @order = Order.new(order_params)
  end

  def complete
    @customer = current_customer
    @cart_items = current_customer.cart_items
  end

  def create
    @customer = current_customer
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    @order.shipping_cost = 900
    @order.customer_id = current_customer.id
    
    #オーダー確定
    if @order.save
      
      @cart_items.each do |cart_item|
        OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount)
      end
      @cart_items.destroy_all
      redirect_to complete_orders_path
    else
      render :confirm
    end
  end
    
    



  def index
    @orders = Order.all
  end

  def show
  end

   private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
  
  def order_params
    params.require(:order).permit(:payment_method,:total_payment)
  end
  
end