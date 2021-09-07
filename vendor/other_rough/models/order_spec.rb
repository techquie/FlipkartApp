require 'rails_helper'

RSpec.describe Order, type: :model do

    subject{ described_class.new(order_date: Time.now,
         customer_id: 1,
         address_id: 1
        ) 
        }

    it 'should not be valid with nil' do
        expect(Order.new).to_not be_valid
    end

    it 'should valid with valid attributes values' do
        expect(subject).to_not be_valid
    end


end