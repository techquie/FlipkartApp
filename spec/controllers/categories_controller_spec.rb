require 'rails_helper'

RSpec.describe CategoriesController,type: :controller do 

	before(:all) do
		@category = Category.create(:name => "Household")
	end
	

	describe 'GET #index' do 

		it 'returns success response' do
			get :index
			expect(response).to be_successful
	    end

		it "responds to html by default" do
			post :create, :params => { :category => { :name => "Household" } }
			expect(response.content_type).to eq "text/html; charset=utf-8"
		end

		it "does not render a different template" do
			get "new"
			expect(response).to_not render_template(:show)
		end

	end	

	describe 'GET #show' do
		it 'returns a success response after create' do
			get :show, params: {id: @category.to_param}
			expect(response).to be_successful
		end
	end

	describe 'UPDATE #update' do
		it 'checks that a category can be updated' do
			@category.update(:name => "New Household")
			expect(Category.find_by :name => "New Household").to eq(@category)

		end
	end

	describe 'DELETE #destry' do
		it 'checks that a category can be destroyed' do
			count =  Category.count
			@category.destroy

			expect(Category.count).to eq(count - 1)
		end		
	end

end	