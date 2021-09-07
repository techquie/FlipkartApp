

class SimpleClass
    attr_accessor :message

    def initialize()
        puts "initializing a new instance"
        @message = "Hello SimpleClass"
    end

    def update_message(new_message)
        @message = new_message
    end
end
describe SimpleClass do
    before(:each) do
        @simple_class = SimpleClass.new 
    end

    it 'should have an initial message' do
        puts expect(@simple_class).to_not be_nil
        @simple_class.message = "Updated new message"
    end

    it 'should be able to change message' do
        @simple_class.update_message('a new message')
        puts expect(@simple_class.message).to_not be 'Hello SimpleClass'
    end

end

describe 'Before and After Hook' do
    before(:each) do
        puts "run before each example"
    end

    before(:all) do
        puts "run before all example"
    end

    after(:all) do
        puts "run after all example"
    end

    it 'run to test first example' do
        puts "running first example"
    end

    it 'run to test second example' do
        puts 'running second example'
    end
end