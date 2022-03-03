require "./lib/item_repo"
require "./lib/sales_engine"
require "./lib/item"
require "./lib/customer"
require "Time"
require "pry"

RSpec.describe Customer do
  let(:customer) do
    Customer.new({
      id: 1,
      first_name: "Mister",
      last_name: "Customer",
      created_at: Time.now,
      updated_at: Time.now
    })
  end

  it "is an instance of Customer" do
    expect(customer).to be_an_instance_of(Customer)
  end

  it "has all expected attributes" do
    expect(customer.customer_attributes[:id]).to eq(1)
    expect(customer.customer_attributes[:first_name]).to eq("mister")
    expect(customer.customer_attributes[:last_name]).to eq("customer")
    expect(customer.customer_attributes[:created_at]).to be_an_instance_of(Time)
    expect(customer.customer_attributes[:updated_at]).to be_an_instance_of(Time)
  end
end
