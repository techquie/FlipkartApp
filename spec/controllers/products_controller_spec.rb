require 'rails_helper'

RSpec.describe ProductsController, type: :request do

    before{
        @current_category = Category.first_or_create!(name: 'Furniture')
        @current_seller = Seller.first_or_create!(name: 'kundan', email: 'kundan@gmail.com',password: "kundan",password_confirmation:"kundan")
      }
      
      let(:valid_attributes) do
        {
          name: 'Mi Note 8 Pro',
          price: 1200,
          quantity: 12,
          description: "Mi Note 8 Pro Multicolor option 6/8GB RAM",
          category_id: @current_category.id,
          seller_id: @current_seller.id,   
        }
      end
   
      let(:invalid_attributes) do
        {
            name: 'Mi',
            price: 0,
            quantity: 12,
            description: "",
            category_id: @current_category.id,
            seller_id: @current_seller.id,
        }
      end

      #let! will implicitly called before, and create object instantily

      let!(:valid_attributes_2) do
      {
        name: 'Mi Note 8 Pro',
        price: 1200,
        quantity: 12,
        description: "Mi Note 8 Pro Multicolor option 6/8GB RAM",
        category_id: @current_category.id,
        seller_id: @current_seller.id,   
      }
      end

      describe 'Product#create' do
        it 'check valid object creation' do
          product = Product.create!(valid_attributes)
          expect(product).to be_a_kind_of Product
        end
      end

end

