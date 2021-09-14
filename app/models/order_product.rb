class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  after_create :update_quantity

  def update_quantity
    @product = self.product
    @product.update(quantity: @product.quantity - self.quantity)
  end
  
end
