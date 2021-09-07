require 'rails_helper'

=begin
RSpec.describe Category, type: :model do

    it 'is valid without attribute name' do
        expect(Category.new).to_not be_valid
    end
    it 'is valid with valid attribute name' do
        @category = Category.new
        @category.name = 'House Hold'
        expect(@category).to be_valid
    end

end

=end


RSpec.describe Category , :type => :model do


  context 'tests for validations' do

    it 'ensures Category name exist' do
      category=build(:category,name:'Garments')
      expect(category.save).to eq(false)
    end

    it 'save Category successfully' do
      category=category=build(:category)
      expect(category.save).to eq(true)
    end

  end  


end

