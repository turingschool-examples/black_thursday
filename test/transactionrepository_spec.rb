require 'bigdecimal'
require 'bigdecimal/util'
require 'objspace'
require './lib/sales_engine'
require 'csv'
require 'rspec'
require './lib/transaction'
require './lib/transactionrepository'

describe TransactionRepository do
  it 'exists' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    transaction = se.transactions

    expect(transaction).to be_a(TransactionRepository)
  end

  it 'finds by id' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    transaction = se.transactions

    trans1 = transaction.find_by_id(6)
    trans2 = transaction.find_by_id(390)

    expect(trans1.credit_card_number).to eq("4558368405929183")
    expect(trans2.result).to eq("success")
  end

  it 'finds all by invoice id' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    transaction = se.transactions

    trans1 = transaction.find_all_by_invoice_id(2668)

    expect(trans1[0].id).to eq(20)
  end

  it 'finds all by credit card number' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    transaction = se.transactions

    trans1 = transaction.find_all_by_credit_card_number("4625296309157421")

    expect(trans1[0].id).to eq(12)
    expect(trans1[0].credit_card_expiration_date).to eq("0614")
  end

  it 'finds all by credit card number' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    transaction = se.transactions

    trans1 = transaction.find_all_by_result("failed")

    expect(trans1.count).to eq(827)
    expect(trans1[3].invoice_id).to eq(3792)
  end

  it 'creates attributes' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    transaction = se.transactions

    attributes = {
                  :id                           => 4986,
                  :invoice_id                   => 1111111,
                  :credit_card_number           => "42424242424",
                  :credit_card_expiration_date  => "0822",
                  :result                       => "failed",
                  :created_at                   => "2020-08-18",
                  :updated_at                   => "2021-09-18"
                  }

    expect(transaction.all.length).to eq(4985)
    transaction.create(attributes)
    expect(transaction.all.length).to eq(4986)
  end

  it "can update attributes" do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    transaction = se.transactions

    attribute = {
                  :id                           => 192,
                  :invoice_id                   => 1834,
                  :credit_card_number           => "4382021679578900",
                  :credit_card_expiration_date  => "1119",
                  :result                       => "success",
                  :created_at                   => "2012-02-26 20:57:03 UTC",
                  :updated_at                   => Time.now
                  }

    results = {
                  :id                           => 192,
                  :invoice_id                   => 1834,
                  :credit_card_number           => "4382021679578900",
                  :credit_card_expiration_date  => "1119",
                  :result                       => "success",
                  :created_at                   => "2012-02-26 20:57:03 UTC",
                  :updated_at                   => Time.now
                  }

  transaction_results = Transaction.new(results)

  expect(transaction.update(192, attribute).result).to eq(transaction_results.result)
  expect(transaction.update(192, attribute).credit_card_number).to eq(transaction_results.credit_card_number)
  end

  it 'deletes a transaction' do
    se = SalesEngine.new({ :items      => "./data/items.csv",
                       :merchants      => "./data/merchants.csv",
                       :invoices       => './data/invoices.csv',
                       :invoice_items  => './data/invoice_items.csv',
                       :transactions   => './data/transactions.csv',
                       :customers      => './data/customers.csv'})
    transaction = se.transactions

    expect(transaction.delete(176).length).to eq(4984)
  end
end
