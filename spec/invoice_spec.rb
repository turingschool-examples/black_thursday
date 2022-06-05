require 'csv'
require './lib/invoice'

RSpec.describe Invoice do
  before :each do
    @i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now,
  })
  end

  it "exists" do
  expect(@i).to be_instance_of Invoice
  end

  it "has an id" do
    expect(@i.id).to eq(6)
  end

  it "has a customer id" do
    expect(@i.customer_id).to eq(7)
    end

  it "has a merchant id" do
    expect(@i.merchant_id).to eq(8)
  end

  it "has a status" do
    expect(@i.status).to eq("pending")
  end

  it "has created_at" do
    expect(@i.created_at).to be_a Time
  end

  it "has updated_at" do
    expect(@i.updated_at).to be_a Time
  end
end
