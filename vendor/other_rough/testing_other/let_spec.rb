describe "GetTime" do
    let!(:current_time) { Time.now }
    before(:each) do
        puts "before #{Time.now }"
    end
    it "gets the time" do
        sleep(3)
        puts "gets #{current_time }"
    end
end