require 'rails_helper'

RSpec.describe Seller, type: :model do
    it 'returns the name for a seller' do
        seller = build(:seller, name: 'Rajesh Kumar')
        expect(seller.name).to_not eq 'Rajesh'
    end

    it 'returns the name for a seller' do
        seller = build(:seller, name: 'Rajesh Kumar')
        expect(seller.name).to eq 'Rajesh Kumar'
    end
end