require 'rails_helper'

RSpec.describe Payment, type: :model do

    subject{ described_class.new(mode: "wallet", order: Order.new) }

    it 'should not be valid with nil' do
        expect(Payment.new).to_not be_valid
    end

    it 'should be valid with valid attributes values' do
        expect(subject).to be_valid
    end


end