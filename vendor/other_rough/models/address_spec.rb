require 'rails_helper'

RSpec.describe Address do
    subject {
        Address.new(
            city: "Gaya", 
            pincode: 124578, 
            contact: "4578564578", 
            customer:Customer.new)
        }

    it 'should not be valid with empty object' do
        expect(Address.new).to_not be_valid
    end

    it 'should be valid with attribute' do
        expect(subject).to be_valid
    end

    it 'should not valid with nil city' do
        subject.city = nil
        expect(subject).to_not be_valid
    end

    it 'should not be valid with wrong city attribute value' do
        subject.city = "G"
        expect(subject).to_not be_valid
    end
    
end


