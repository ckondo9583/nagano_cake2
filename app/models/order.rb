class Order < ApplicationRecord
  belongs_to :admin
  belongs_to :customer
end
