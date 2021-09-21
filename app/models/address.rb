class Address < ApplicationRecord
  belongs_to :customer
  has_many :order
  attr_accessor :page

  validates :city, presence: true, length: {minimum: 2, maximum: 20}
  validates :pincode, presence: true, numericality: true, length: {minimum: 6, maximum: 6}
  validates :customer_id, presence: true
  validates :contact, presence: true, length: {minimum: 10, maximum: 12}

  before_save :ensure_only_one_default_address

  def ensure_only_one_default_address
    return unless default?
    self.class.where(customer_id: customer_id).update_all(default: false)
  end

end
