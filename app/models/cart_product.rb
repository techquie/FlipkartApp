class CartProduct < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  has_one :customer, through: :cart
  
  @total
  @subtotal
  @unit_price
  
  def find_unit_price
    @unit_price = product.price
  end

  def find_subtotal
    @subtotal = unit_price * quantity
  end
  
end
