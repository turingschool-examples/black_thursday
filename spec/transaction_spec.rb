require "./lib/transaction"
require "bigdecimal"
require "Rspec"

RSpec.describe Transaction do

  it "exists" do
    data = ({:id => 1,
    :invoice_id => 1,
    :credit_card_number => 0000000000000000,
    :result => 13635,
    :created_at  => Time.now,
    :updated_at  => Time.now})
    transaction = Transaction.new(data)
    expect(transaction).to be_instance_of(Transaction)
  end

  it "can return the details of a transaction" do
    data = ({:id => 1,
    :invoice_id => 1,
    :credit_card_number => 0000000000000000,
    :result => 13635,
    :created_at  => Time.now.round,
    :updated_at  => Time.now.round})

    transaction = Transaction.new(data)
    expect(transaction.id).to eq(1)
    expect(transaction.invoice_id).to eq(1)
    expect(transaction.credit_card_number).to eq(0000000000000000)
    expect(transaction.created_at).to eq(Time.now.round)
    expect(transaction.updated_at).to eq(Time.now.round)
  end
end
