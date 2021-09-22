require 'rails_helper'

RSpec.describe Seller, type: :model do
    
    subject {
        Seller.new(name: "Kundan Kumar", email: "kundan@gmail.com", password: "kundan")
    }

    it 'returns the name for a seller' do
        seller = build(:seller, name: 'Rajesh Kumar')
        expect(seller.name).to_not eq 'Rajesh'
    end

    it 'returns the name for a seller' do
        seller = build(:seller, name: 'Rajesh Kumar')
        expect(seller.name).to eq 'Rajesh Kumar'
    end

    it 'return error email can not be nil' do
        subject.email = nil
        expect(subject.save).to eq false
    end
    
    it 'return error name can not be less than 5 char' do
        subject.name = "ma"
        expect(subject.save).to eq false
    end

    it 'return error name can not be more than 20 char' do
        subject.name = "adfna skhfhdsf keabsfyiewhfyg ewifiewufb"
        expect(subject.save).to eq false
    end

    it 'return error email for uniqueness' do
        seller_1 = Seller.create(name: 'kundan', email: 'kundan@gmail.com', password: 'kundan')
        seller_2 = Seller.new(name: 'rajukumar', email: 'kundan@gmail.com', password: 'rajukumar')
        expect(seller_2.save).to eq false
    end
end