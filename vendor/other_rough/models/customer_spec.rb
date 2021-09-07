require 'rails_helper'

RSpec.describe Customer, type: :model do
    
    subject {
        Customer.new(name: "Raju Kumar", email: "kundan@gmail.com", password: "kundan")
    }
    it 'is valid class' do
        expect(Customer.new).to_not be_nil
    end

    it 'should valid with attributes' do
        expect(subject).to be_valid
    end

    it 'should not be valid without attributes name' do
        subject.name = "Raju"
        expect(subject).to_not be_valid
    end

    it 'should not be valid without attributes email' do
        subject.email = nil
        expect(subject).to_not be_valid
    end

    it 'should not be valid without attributes password' do
        subject.password = nil
        expect(subject).to_not be_valid
    end

    it 'empty attribute should not be valid' do
        subject.name = nil
        subject.email = nil
        subject.password = nil
        expect(subject).to_not be_valid
    end

end