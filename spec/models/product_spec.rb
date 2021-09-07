require 'rails_helper'

RSpec.describe Product, type: :model do
    it 'returns the name for a customer' do
        product = build(:product, name: 'Mi Note 9 Pro')
        expect(product.name).to_not eq 'Mi Note '
    end

    it 'returns the name for a customer' do
        customer = build(:customer, name: 'Mi Note 9 Pro')
        expect(customer.name).to eq 'Mi Note 9 Pro'
    end
end