 class Item < ApplicationRecord
  belongs_to :admin
  has_many :cart_items
  has_many :order_details
 end
     