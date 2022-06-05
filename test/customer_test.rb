require 'simplecov'
SimpleCov.start
require './lib/helper'

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

  it 'returns item id' do
    expect(customer.item_id).to eq(7)
  end

  it 'returns invoice id' do
    expect(customer.invoice_id).to eq(8)
  end

  it 'returns quantity' do
    expect(customer.quantity).to eq(1)
  end

  it 'returns unit price' do
    expect(customer.unit_price).to eq(10.99)
  end

  it "can return the time the customer was created" do
    expect(customer.created_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

  it "can return the time the object was updated" do
    expect(customer.updated_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

  xit "can return the unit price converted to dollars" do
    expect(customer.unit_price_to_dollars).to eq(10.99)
  end
end
