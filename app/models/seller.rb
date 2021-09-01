class Seller < ApplicationRecord
    has_many :product, dependent: :destroy

    validates :name, presence: true, length: {minimum: 5, maximum: 20}
    validates :password, presence: true, length: {minimum: 5, maximum: 10}
    validates :email, uniqueness: true, presence: true 
end
