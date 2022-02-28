require "./lib/customer_repository"
require "rspec"
RSpec.describe CustomerRepository do
  it "exists" do
    customer1 = double("customer", :id => 1, :first_name => "Joey", :last_name => "Ondricka", :created_at => 2012-03-27 14:54:09 UTC, :updated_at => 2012-03-27 14:54:09 UTC)
    customer2 = double("customer", :id => 2, :first_name => "Cecelia", :last_name => "Osinski", :created_at => 2012-03-27 14:54:10 UTC, :updated_at => 2012-03-27 14:54:10 UTC)
    customer3 = double("customer", :id => 3, :first_name => "Mariah", :last_name => "Toy", :created_at => 2012-03-27 14:54:10 UTC, :updated_at => 2012-03-27 14:54:10 UTC)
    customer_repo = CustomerRepository([])
    expect(customer_repo).to be_a(CustomerRepository)
  end 
end 
