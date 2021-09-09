require 'rails_helper'

RSpec.describe FlipkartController, :type=> :controller do
    before{
        @current_user = Customer.first_or_create!(name: 'kundan', email: 'kundan@gmail.com',password: "kundan",password_confirmation:"kundan")
      }

    describe 'GET index' do
        it 'has a 200 status code ' do
            get "index"
            expect(response.status).to eq(200)
        end
    end

    describe 'GET index' do
        it 'return response successfully' do
            get "index"
            expect(response).to be_successful
        end
    end

    describe 'GET /index' do
      it 'renders a response without auth' do
        get 'index'
        expect(response).to be_successful
      end
  
      it 'renders a successful response with auth' do
        sign_in @current_user
        get 'index'
        expect(response).to be_successful
      end
    end
end