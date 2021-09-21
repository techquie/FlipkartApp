require 'rails_helper'

RSpec.describe Product, type: :model do

    before{
        @current_category = Category.first_or_create!(name: 'Furniture')
        @current_seller = Seller.first_or_create!(name: 'kundan', email: 'kundan@gmail.com',password: "kundan",password_confirmation:"kundan")
      }
      subject{
          Product.new(name: 'Mi Note 8 Pro', price: 1200, quantity: 12,
            description: "Mi Note 8 Pro Multicolor option 6/8GB RAM",
            category_id: @current_category.id,
            seller_id: @current_seller.id
        )
      }

    it 'returns the name for a product' do
        product = build(:product, name: 'Mi Note 9 Pro')
        expect(product.name).to_not eq 'Mi Note '
    end

    it 'return error name can not be less than 5 char' do
        subject.name = 'a'
        expect(subject.save).to eq false
        #puts subject.errors.full_messages
    end

    it 'only numerical value accepted for quantity' do
        subject.quantity = 'adf'
        expect(subject.save).to eq false
        puts subject.errors.full_messages
    end

end