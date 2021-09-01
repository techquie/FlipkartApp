class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :address

  has_many :order_product, dependent: :destroy
  
  before_save :set_order_date
  
  def set_order_date
    self[:order_date] = Time.now
  end

end
