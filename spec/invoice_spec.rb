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

  it "returns the customer_id" do
    inv = Invoice.new({
     :id              => 6,
     :customer_id     => 7,
     :status => "pending",
     :created_at  => Time.now,
     :updated_at  => Time.now,
     :merchant_id => 8})

     expect(inv.customer_id).to eq(7)
  end

  it "returns the merchant_id" do
    inv = Invoice.new({
     :id              => 6,
     :customer_id     => 7,
     :status => "pending",
     :created_at  => Time.now,
     :updated_at  => Time.now,
     :merchant_id => 8})

     expect(inv.merchant_id).to eq(8)
   end

   it "returns the status" do
     inv = Invoice.new({
      :id              => 6,
      :customer_id     => 7,
      :status => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 8})

      expect(inv.status).to eq("pending")
    end

    it "returns the time updated at and created at" do
      inv = Invoice.new({
       :id              => 6,
       :customer_id     => 7,
       :status => "pending",
       :created_at  => Time.now.round,
       :updated_at  => Time.now.round,
       :merchant_id => 8})

       expect(inv.created_at).to eq(Time.now.round)
       expect(inv.updated_at).to eq(Time.now.round)
     end
end
