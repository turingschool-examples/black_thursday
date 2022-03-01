require "./lib/sales_engine"
require "./lib/transaction"
require "Time"
require "pry"

RSpec.describe Transaction do
  let(:transaction) do
    Transaction.new({
      id: 3,
      invoice_id: 5,
      credit_card_number: "4111411141114111",
      credit_card_expiration_date: "1125",
      result: "success",
      created_at: Time.now,
      updated_at: Time.now
    })
  end

  it "is an instance of Class:Transaction" do
    expect(transaction).to be_an_instance_of(Transaction)
  end

  it "returns all expected attributes" do
    expect(transaction.transaction_attributes[:id]).to eq 3
    expect(transaction.transaction_attributes[:invoice_id]).to eq 5
    expect(transaction.transaction_attributes[:credit_card_number]).to eq 4111411141114111
    expect(transaction.transaction_attributes[:credit_card_expiration_date]).to eq 1125
    expect(transaction.transaction_attributes[:result]).to eq "success"
    expect(transaction.transaction_attributes[:created_at]).to be_an_instance_of(Time)
    expect(transaction.transaction_attributes[:updated_at]).to be_an_instance_of(Time)
  end
end
