require 'rails_helper'

RSpec.describe CartProduct, type: :model do

    subject{ described_class.new(quantity: 0, cart: Cart.new, product: Product.new) }

    it 'should not be valid with nil' do
        expect(CartProduct.new).to_not be_valid
    end

    it 'should be valid with valid attributes values' do
        expect(subject).to be_valid
    end


end