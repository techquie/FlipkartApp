require 'rails_helper'

RSpec.describe CustomersController,type: :controller do 
    
    subject {
        Customer.new(name: "Kundan Kumar", email: "kundan@gmail.com", password: "kundan")
    }
    describe 'GET index' do
        it 'has a 200 status code ' do
            get "index"
            expect(response.status).to eq(200)
        end
    end

    describe 'GET #show' do 
        it "responds to show html after create" do
            puts "Before save count = #{Customer.count}"
			customer = Customer.create!( :name => "Kundan Verma", :email => 'kundan@gmail.com', :password => 'kundan')
            puts "After save count = #{Customer.count}"
			get :show, params: {id: customer.to_param}
            expect(response).to render_template(:show)
		end
    end

	describe 'GET #edit' do 
        it "responds to edit html after create and update" do
            puts "Before save count = #{Customer.count}"
			customer = Customer.create!( :name => "Kundan Verma", :email => 'kundan@gmail.com', :password => 'kundan')
            
            customer.update(:name => "New Name")
			expect(Customer.find_by :name => "New Name").to eq(customer)

            puts "After save and edit count = #{Customer.count}"
			get :edit, params: {id: customer.to_param}
            
            expect(response).to render_template(:edit)
		end
    end

    describe 'GET #destroy' do 
        it "responds to(redirect_to) index html after destroy" do
            puts "Before destroy count = #{Customer.count}"
			customer = Customer.create!( :name => "Kundan Verma", :email => 'sanu@gmail.com', :password => 'kundan')
            puts "After create count = #{Customer.count}"

			delete :destroy, params: {id: customer.to_param}
            puts "After destroy count = #{Customer.count}"

            expect(response).to redirect_to(:customers)
		end
    end
	

end