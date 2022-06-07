require_relative 'simplecov'
SimpleCov.start
require_relative './lib/helper'

RSpec.describe Transaction do
  let!(:time) {Time.now}
  let!(:transaction) {Transaction.new({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
  })}

  it "exists" do
    expect(transaction).to be_instance_of Transaction
  end

  it 'returns id' do
    expect(transaction.id).to eq(6)
  end

  it 'returns invoice id' do
    expect(transaction.invoice_id).to eq(8)
  end

  it 'returns result' do
    expect(transaction.result).to eq("success")
  end

  it 'returns credit_card_number' do
    expect(transaction.credit_card_number).to eq("4242424242424242")
  end

  it 'returns credit card expiration date' do
    expect(transaction.credit_card_expiration_date).to eq("0220")
  end

  it "can return the time the transaction was created" do
    expect(transaction.created_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end

  it "can return the time the object was updated" do
    expect(transaction.updated_at.strftime("%Y-%m-%d %H:%M")).to eq(time.strftime("%Y-%m-%d %H:%M"))
  end
end
