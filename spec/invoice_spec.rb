require './lib/item'
require 'time'
require 'bigdecimal'
require './lib/invoice.rb'

RSpec.describe Invoice do

  it "exists" do
    inv = Invoice.new({
     :id              => 6,
     :customer_id     => 7,
     :status => "pending",
     :created_at  => Time.now,
     :updated_at  => Time.now,
     :merchant_id => 8})

     	expect(inv).to be_instance_of(Invoice)
  end

  it "returns the id" do
    inv = Invoice.new({
     :id              => 6,
     :customer_id     => 7,
     :status => "pending",
     :created_at  => Time.now,
     :updated_at  => Time.now,
     :merchant_id => 8})

     expect(inv.id).to eq(6)
  end
end
