describe "testing tags how it works" do
    it 'it is slow tag', :slow => true do
        sleep 10
        puts 'This is slow tag'
    end

    it 'it is fast tag', :slow => true do
        puts 'This is fast tag'
    end
end
