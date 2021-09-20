require './lib/item'
require './lib/itemrepository'
require 'bigdecimal'
require 'bigdecimal/util'
require 'objspace'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchantrepository'
require './lib/invoice'
require 'csv'
require './lib/invoice_item'
require './lib/invoice_item_repo'
require 'rspec'
require './lib/transaction'
require './lib/transactionrepository'

describe TransactionRepository do
  it 'exists' do
    se = SalesEngine.new({ :items     => "./data/items.csv",
                      :merchants      => "./data/merchants.csv",
                      :invoices       => './data/invoices.csv',
                      :invoice_items  => './data/invoice_items.csv',
                      :transactions   => './data/transactions.csv'})
    transaction = se.transactions

    expect(transaction).to be_a(TransactionRepository)
  end

  it 'finds by id' do
    se = SalesEngine.new({ :items     => "./data/items.csv",
                      :merchants      => "./data/merchants.csv",
                      :invoices       => './data/invoices.csv',
                      :invoice_items  => './data/invoice_items.csv',
                      :transactions   => './data/transactions.csv'})
    transaction = se.transactions

    trans1 = transaction.find_by_id(6)
    trans2 = transaction.find_by_id(390)

    expect(trans1.credit_card_number).to eq("4558368405929183")
    expect(trans2.result).to eq("success")
  end

  it 'finds all by invoice id' do
    se = SalesEngine.new({ :items     => "./data/items.csv",
                      :merchants      => "./data/merchants.csv",
                      :invoices       => './data/invoices.csv',
                      :invoice_items  => './data/invoice_items.csv',
                      :transactions   => './data/transactions.csv'})
    transaction = se.transactions

    trans1 = transaction.find_all_by_invoice_id(2668)

    expect(trans1[0].id).to eq(20)
  end

  it 'finds all by invoice id' do
    se = SalesEngine.new({ :items     => "./data/items.csv",
                      :merchants      => "./data/merchants.csv",
                      :invoices       => './data/invoices.csv',
                      :invoice_items  => './data/invoice_items.csv',
                      :transactions   => './data/transactions.csv'})
    transaction = se.transactions

    trans1 = transaction.find_all_by_invoice_id(2668)

    expect(trans1[0].id).to eq(20)
  end
end
