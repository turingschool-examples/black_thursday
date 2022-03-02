require 'csv'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction_repository'
require_relative 'spec_helper'

RSpec.describe TransactionRepository do

  before(:each) do
    se = SalesEngine.from_csv({ customers: "./data/customers.csv", invoice_items: "./data/invoice_items.csv",
       invoices: "./data/invoices.csv", items: "./data/items.csv",
       merchants: "./data/merchants.csv", transactions: "./data/transactions.csv"})
    @transactions = se.transactions
  end

  it "exists" do
    expect(@transactions).to be_a(TransactionRepository)
  end

  it "#find_all_by_credit_card_number" do
     credit_card_number = "4848466917766329"
     expected = @transactions.find_all_by_credit_card_number(credit_card_number)

     expect(expected.length).to eq 1
     expect(expected.first.class).to eq Transaction
     expect(expected.first.credit_card_number).to eq credit_card_number

     credit_card_number = "4848466917766328"
     expected = @transactions.find_all_by_credit_card_number(credit_card_number)

     expect(expected.empty?).to eq true
  end
# find_all_by_credit_card_number - returns either [] or
# one or more matches which have a matching credit card number

  it "#find_all_by_result" do

#    result = :success
    result = "success"
    expected = @transactions.find_all_by_result(result)

     expect(expected.length).to eq 4158
     expect(expected.first.class).to eq Transaction
     expect(expected.first.result).to eq result

#     result = :failed
     result = "failed"
     expected = @transactions.find_all_by_result(result)

     expect(expected.length).to eq 827
     expect(expected.first.class).to eq Transaction
     expect(expected.first.result).to eq result
  end
#find_all_by_result - returns either []
# or one or more matches which have a matching status
end
