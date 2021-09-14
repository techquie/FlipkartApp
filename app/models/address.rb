class Address < ApplicationRecord
  belongs_to :customer
  has_many :order

  validates :city, presence: true, length: {minimum: 2, maximum: 20}
  validates :pincode, presence: true, numericality: true, length: {minimum: 6, maximum: 6}
  validates :customer_id, presence: true
  validates :contact, presence: true, length: {minimum: 10, maximum: 12}
end
