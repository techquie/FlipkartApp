require 'rails_helper'

RSpec.describe Wallet, type: :model do

    subject{ described_class.new(amount: 1000, pin: 12345, customer_id: 1) }

    it 'should not be valid with nil' do
        expect(Wallet.new).to_not be_valid
    end

    it 'should(not customer_id = 1) be valid with valid attributes values' do
        expect(subject).to_not be_valid
    end


end