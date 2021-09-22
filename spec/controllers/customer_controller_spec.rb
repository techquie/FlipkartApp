require 'rails_helper'

RSpec.describe CustomersController,type: :controller do 
    
    subject {
        Customer.new(name: "Kundan Kumar", email: "kundan@gmail.com", password: "kundan")
    }

    before(:all) do
        @cart_count = Cart.count
        @wallet_count = Wallet.count
    end

    describe 'Check for Customer' do
        it 'check for change cart count after customer create' do
            customer = Customer.new( :name => "Kundan Verma", :email => 'kundan123@gmail.com', :password => 'kundan')
            expect { customer.save }.to change { Cart.count }.by(1)

            expect(Cart.count).to eq(@cart_count + 1)
        end
    end

    describe 'Check for Customer' do
        it 'check for change wallet count after customer create' do
            customer = Customer.new( :name => "Kundan Verma", :email => 'kundan123@gmail.com', :password => 'kundan')
            expect { customer.save }.to change { Wallet.count }.by(1)

            expect(Wallet.count).to eq(@wallet_count + 1)
        end
    
        it 'check for change cart count after customer create' do
            customer = Customer.new( :name => "Kundan Verma", :email => 'kundan123@gmail.com', :password => 'kundan')
            expect { customer.save }.to change { Cart.count }.by(1)
        end
    end

    describe 'GET index' do
        it 'has a 200 status code ' do
            get "index"
            expect(response.status).to eq(200)
        end
    end

    describe 'GET #show' do 
        it "responds to show html after create" do
            customer = Customer.create!( :name => "Kundan Verma", :email => 'kundan1@gmail.com', :password => 'kundan')
            get :show, params: {id: customer.to_param}
            expect(response).to render_template(:show)
		end
    end

	describe 'GET #edit' do 
        it "responds to edit html after create and update" do
            customer = Customer.create!( :name => "Kundan Verma", :email => 'kundan2@gmail.com', :password => 'kundan')
            customer.update(:name => "New Name")
			expect(Customer.find_by :name => "New Name").to eq(customer)
			get :edit, params: {id: customer.to_param}
            
            expect(response).to render_template(:edit)
		end
    end

    describe 'GET #destroy' do 
        it "responds to(redirect_to) index html after destroy" do
            customer = Customer.create!( :name => "Kundan Verma", :email => 'sanu@gmail.com', :password => 'kundan')
			delete :destroy, params: {id: customer.to_param}
            
            expect(response).to redirect_to(:customers)
		end
    end
	

end