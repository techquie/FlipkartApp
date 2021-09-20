class Product < ApplicationRecord
  belongs_to :category
  belongs_to :seller

  has_many :cart_product #, through: :cart
  has_many :order_product #, through: :order
  has_many_attached :images

  validates :name, presence: true, length: {minimum: 6, maximum: 30}
  validates :price, presence: true, length: {minimum: 1, maximum: 10} #, numericality: true
  validates :description, presence: true, length: {minimum: 20, maximum: 500}
  validates :quantity, presence: true, numericality: true
  validates :category, presence: true
  validates :seller, presence: true
  #validates :images, presence: true

  def self.to_csv(fields = column_names, options = {})
    CSV.generate do |csv|
      csv << fields
      all.each do |product| 
        csv << product.attributes.values_at(*fields)
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      product_hash = row.to_hash
      begin
        #product = find_or_create_by!(id: product_hash['id'])
        #product.update_attributes(product_hash)
        if Product.exists?(:id=> product_hash['id'])
          product = Product.find(product_hash['id'])
          product.update(product_hash)
        else
          Product.create!(product_hash)
        end
      rescue => e
        return {message: e}
      end
    end
    return {message: "All product added successfully"}
  end
end
