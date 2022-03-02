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
#  find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
#find_all_by_result - returns either [] or one or more matches which have a matching status
end
