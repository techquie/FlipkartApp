require 'rails_helper'

RSpec.describe Cart, type: :model do

    subject{ Cart.new(customer: Customer.new) }

    it 'should not valid without customer' do
        expect(Cart.new).to_not be_valid
    end
    
    it 'should valid with customer' do
        expect(subject).to be_valid
    end

    it 'should not be valid with any customer_id' do
        subject.customer_id = 10
        expect(subject).to_not be_valid
    end

    it 'should not be valid without customer_id attribute' do
        subject.customer_id = 0
        expect(subject).to_not be_valid
    end

end