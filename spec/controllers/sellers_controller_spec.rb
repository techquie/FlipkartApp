require 'rails_helper'

RSpec.describe SellersController,type: :controller do 
    
    before{
        @current_seller = Seller.first_or_create!(name: 'kundan', email: 'kundan@gmail.com',password: "kundan",password_confirmation:"kundan")
      }

    subject {
        Seller.new(name: "Rajesh Singh", email: "rajesh@gmail.com", password: "rajesh")
    }

    describe 'GET index' do
        it 'has a 200 status code ' do
            get "index"
            expect(response.status).to eq(200)
        end
    end

    describe 'GET #show' do 
        it "responds to show html after create" do
            seller = Seller.create!( :name => "Rajesh Singh", :email => 'rajesh@gmail.com', :password => 'rajesh')
            get :show, params: {id: seller.to_param}
            expect(response).to render_template(:show)
        end
    end

    describe 'GET #edit' do 
        it "responds to edit html after create and update" do
            seller = Seller.create!( :name => "Rajesh Singh", :email => 'rajesh@gmail.com', :password => 'rajesh')
            
            seller.update(:name => "New Name")
            expect(Seller.find_by :name => "New Name").to eq(seller)

            get :edit, params: {id: seller.to_param}
            
            expect(response).to render_template(:edit)
        end
    end

    describe 'GET #destroy' do 
        it "responds to(redirect_to) index html after destroy" do
            seller = Seller.create!( :name => "Rajesh", :email => 'sanu@gmail.com', :password => 'rajesh')
            delete :destroy, params: {id: seller.to_param}
            expect(response).to redirect_to(:sellers)
        end
    end
end