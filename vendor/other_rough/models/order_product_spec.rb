require 'rails_helper'

RSpec.describe OrderProduct, type: :model do

    subject{ described_class.new(quantity: 0, order: Order.new, product: Product.new) }

    it 'should not be valid with nil' do
        expect(OrderProduct.new).to_not be_valid
    end

    it 'should be valid with valid attributes values' do
        expect(subject).to be_valid
    end

    it 'should not be valid with unreferenced cart_id' do
        subject.order = nil
        expect(subject).to_not be_valid
    end

    it 'should not be valid with unreferenced product_id' do
       # subject.order = Order.new
        subject.product = nil
        expect(subject).to_not be_valid
    end

  
end