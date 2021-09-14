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

      #let! will implicitly called before

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


=begin
      describe 'GET #show' do 
        it "responds to show html after create" do
            puts "Before save count = #{Product.count}"
            product = Product.create!(valid_attributes)
            puts "After save count = #{Product.count}"
            get :show, params: {id: product.to_param}
            expect(response).to render_template(:show)
        end
      end
      
      describe "GET /edit" do
        it "renders edit path without auth" do
          product = Product.new(valid_attributes)
          product.seller_id = @current_seller.id
          product.save
          get edit_product_path(product)
          expect(response).to_not be_successful
        end
      end

      describe "GET /edit" do
        it "renders edit path with auth" do
          sign_in @current_user
          product = Product.new(valid_attributes)
          product.seller_id = @current_seller.id
          product.save
          get edit_product_path(:prod_id=>product.id)
          expect(response).to be_successful
        end
=end
end

