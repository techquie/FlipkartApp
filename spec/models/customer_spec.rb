require 'rails_helper'

RSpec.describe Customer, type: :model do
    it 'returns the name for a customer' do
        customer = build(:customer, name: 'Kundan Verma')
        expect(customer.name).to_not eq 'Kundan'
    end

    it 'returns the name for a customer' do
        customer = build(:customer, name: 'Kundan Verma')
        expect(customer.name).to eq 'Kundan Verma'
    end
end