class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :address

  has_many :order_product, dependent: :destroy
  
  before_save :set_order_date
  

  def set_order_date
    self[:order_date] = Time.now
  end

  validates :order_date, presence: true
  validates :customer_id, presence: true
  validates :address_id, presence: true
end
