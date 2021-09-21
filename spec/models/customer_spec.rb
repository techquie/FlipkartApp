require 'rails_helper'

RSpec.describe Customer, type: :model do
 
    subject {
        Customer.new(name: "Kundan Kumar", email: "kundan@gmail.com", password: "kundan")
    }
    it 'returns the name for a customer' do
        customer = build(:customer, name: 'Kundan Verma')
        expect(customer.name).to_not eq 'Kundan'
    end

    it 'returns the name for a customer' do
        customer = build(:customer, name: 'Kundan Verma')
        expect(customer.name).to eq 'Kundan Verma'
    end

    it 'return error email can not be nil' do
        subject.email = nil
        expect(subject.save).to eq false
        #puts subject.errors.full_messages
    end

    it 'return error name can not be less than 5 char' do
        subject.name = "ma"
        expect(subject.save).to eq false
        #puts subject.errors.full_messages
    end

    it 'return error name can not be more than 20 char' do
        subject.name = "adfna skhfhdsf keabsfyiewhfyg ewifiewufb"
        expect(subject.save).to eq false
        #puts subject.errors.full_messages
    end

    it 'return error email for uniqueness' do
        customer_1 = Customer.create(name: 'kundan', email: 'kundan@gmail.com', password: 'kundan')
        customer_2 = Customer.new(name: 'rajukumar', email: 'kundan@gmail.com', password: 'rajukumar')
        expect(customer_2.save).to eq false
        puts customer_2.errors.full_messages
    end
end