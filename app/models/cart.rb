class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_product, dependent: :destroy

end
