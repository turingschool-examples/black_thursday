require "./lib/customer_repository"
require "rspec"
RSpec.describe CustomerRepository do
  it "exists" do
    customer1 = double("customer", :id => 1, :first_name => "Joey", :last_name => "Ondricka", :created_at => "2012-03-27 14:54:09 UTC", :updated_at => "2012-03-27 14:54:09 UTC")
    customer2 = double("customer", :id => 2, :first_name => "Cecelia", :last_name => "Osinski", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer3 = double("customer", :id => 3, :first_name => "Mariah", :last_name => "Toy", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer_repo = CustomerRepository.new([customer1, customer2, customer3])
    expect(customer_repo).to be_a(CustomerRepository)
  end 
  it "can find all first names" do
    customer1 = double("customer", :id => 1, :first_name => "Joey", :last_name => "Ondricka", :created_at => "2012-03-27 14:54:09 UTC", :updated_at => "2012-03-27 14:54:09 UTC")
    customer2 = double("customer", :id => 2, :first_name => "Cecelia", :last_name => "Osinski", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer3 = double("customer", :id => 3, :first_name => "Joey", :last_name => "Toy", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer_repo = CustomerRepository.new([customer1, customer2, customer3])
    expect(customer_repo.find_all_by_first_name("Joey")).to eq([customer1, customer3])
    expect(customer_repo.find_all_by_first_name("Cecelia")).to eq([customer2])
  end 
  it "can find all last names" do
    customer1 = double("customer1", :id => 1, :first_name => "Bruce", :last_name => "Ondricka", :created_at => "2012-03-27 14:54:09 UTC", :updated_at => "2012-03-27 14:54:09 UTC")
    customer2 = double("customer2", :id => 2, :first_name => "Cecelia", :last_name => "Osinski", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer3 = double("customer3", :id => 3, :first_name => "Joey", :last_name => "Osinski", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC")
    customer_repo = CustomerRepository.new([customer1, customer2, customer3])
    expect(customer_repo.find_all_by_last_name("Osinski")).to eq([customer2, customer3])
    expect(customer_repo.find_all_by_last_name("Ondricka")).to eq([customer1])
  end 
end  
