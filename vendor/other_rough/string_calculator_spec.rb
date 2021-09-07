
require 'testing_other/string_analyzer'
#require 'testing_other/string_calculator'

#describe StringCalculator do

#end


describe StringAnalyzer do
    context 'With valid input' do
        it 'should detect when string contains vowels' do
            sa = StringAnalyzer.new
            str = "Hello Peter"
            abc = expect(sa.has_vowels? str).to be true
            puts abc
        end
    end
end

describe 'An example of true/false/nil Matched' do
    it 'should show how to the true/false/nil' do
        x = true
        y = false
        z = nil
        a = "testing"
        
        puts expect(x).to be true
        puts expect(y).to be false 
        puts expect(a).to be_truthy
        #puts expect(z).to be_falsely
        puts expect(z).to be_nil

        puts expect { 1/0 }.to raise_error(ZeroDivisionError)
        puts expect { 1/0 }.to raise_error("divided by 0") 
        puts expect { 1/0 }.to raise_error("divided by 0", ZeroDivisionError) 

    end
end
require 'testing_other/student'

describe Student do
    it 'the list_student_names method should work correctly' do 
        student1 = double('student')
        student2 = double('student')

        allow(student1).to receive(:name){ 'Kundan Verma' }
        allow(student2).to receive(:name){ 'Aman Kumar' }

        cr = Student.new [student1, student2]
        expect(cr.list_student_names).to eq("Kundan Verma,Aman Kumar")
    end
end

