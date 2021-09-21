class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  #check with console
  has_many :customers, through: :orders
  
  after_create :update_quantity

  def update_quantity
    #product.update(quantity: @product.quantity - self.quantity)
    product = self.product
    product.update(quantity: product.quantity - self.quantity)
  end
  
end
