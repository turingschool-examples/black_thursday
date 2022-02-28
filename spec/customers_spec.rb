require "./lib/customers"
require "rspec"
RSpec.describe Customer do
  it "exists" do
    c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
  })
  expect(c).to be_a(Customer)
  end
  
  it "has readable attributes" do
    c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
  })
    expect(c.id).to eq(6)
    expect(c.first_name).to eq("Joan")
    expect(c.last_name).to eq("Clarke")
    expect(c.created_at).to be_a(Time)
    expect(c.updated_at).to be_a(Time)
  end
end 
