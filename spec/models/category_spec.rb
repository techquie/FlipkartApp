require 'rails_helper'

RSpec.describe Category, type: :model do
    it 'returns the name of category' do
        category = build(:category, name: 'Electronics')
        expect(category.name).to eq 'Electronics'
    end

    it 'returns the name of category' do
        category = build(:category, name: 'Household')
        expect(category.name).to_not eq 'Electronics'
    end

    context 'tests for validations' do
        it 'check for Category name exist' do
          category = build(:category, name:'')
          expect(category.save).to eq(false)
        end
    
        it 'save category successfully' do
          category = build(:category)
          expect(category.save).to eq(true)
        end
      end  
end