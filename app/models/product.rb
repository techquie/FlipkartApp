class Product < ApplicationRecord
  belongs_to :category
  belongs_to :seller

  has_many :cart_product

  validates :name, presence: true, length: {minimum: 6, maximum: 30}
  validates :price, presence: true, length: {minimum: 1, maximum: 10}, numericality: true
  validates :description, presence: true, length: {minimum: 20, maximum: 100}
  validates :quantity, presence: true, numericality: true
  validates :category, presence: true
  validates :seller, presence: true

  
end
