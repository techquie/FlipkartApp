ActiveAdmin.register Product do

  scope :all

  permit_params :name, :price, :description, :quantity, :category_id, :seller_id
end
