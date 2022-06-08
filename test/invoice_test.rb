require 'simplecov'
require './lib/helper'

RSpec.describe Invoice do
  let!(:time) {Time.now}
  let!(:invoice) {Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now })}

  it 'exists' do
    expect(invoice).to be_instance_of(Invoice)
  end

  it "can return an invoice id" do
    expect(invoice.id).to eq(6)
    expect(invoice.id).to be_a Integer
    expect(invoice.id).not_to eq(nil)
  end

  it "can return a merchant id" do
    expect(invoice.merchant_id).to eq(8)
    expect(invoice.merchant_id).to be_a Integer
    expect(invoice.merchant_id).not_to eq(nil)
  end

  it "can return a customer id" do
    expect(invoice.customer_id).to eq(7)
    expect(invoice.customer_id).to be_a Integer
    expect(invoice.customer_id).not_to eq(nil)
  end

  it "can return current invoice status" do
    expect(invoice.status).to eq("pending")
    expect(invoice.status).not_to eq("shipped")
    expect(invoice.status).to be_a String
  end

  it "can return the time the object was created" do
    expect(invoice.created_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

  it "can return the time the object was updated" do
    expect(invoice.updated_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end
end
