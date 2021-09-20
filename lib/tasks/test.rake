namespace :test do
    desc "Test running a rake task"
    task testing: :environment do
        puts "Hello testing"
    end
end