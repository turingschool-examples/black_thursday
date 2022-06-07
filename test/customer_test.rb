require_relative 'simplecov'
SimpleCov.start
require_relative './lib/helper'

RSpec.describe Customer do
  let!(:time) {Time.now}
  let!(:customer) {Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
  })}

  it "exists" do
    expect(customer).to be_instance_of Customer
  end

  it 'returns id' do
    expect(customer.id).to eq(6)
  end

  it "returns first name" do
    expect(customer.first_name).to eq("Joan")
  end

  it "returns last name" do
    expect(customer.last_name).to eq("Clarke")
  end

  it "can return the time the customer was created" do
    expect(customer.created_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

  it "can return the time the object was updated" do
    expect(customer.updated_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end
end
