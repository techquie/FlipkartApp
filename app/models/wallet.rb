class Wallet < ApplicationRecord
  belongs_to :customer
  
  validates :amount, presence: true
  validates :pin, presence: true, length: {minimum: 1, maximum: 10 }
  validates :customer_id, presence: true, uniqueness: true
end
