class Address < ApplicationRecord
  belongs_to :customer
  has_many :order

  
end
