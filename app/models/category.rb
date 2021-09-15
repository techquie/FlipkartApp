class Category < ApplicationRecord
    has_many :product, dependent: :destroy
    
    validates :name, presence: true, length: {minimum: 5, maximum: 20}, 
    uniqueness: {case_sensitive: false, message: '"%{value}" is already exists'}
end
