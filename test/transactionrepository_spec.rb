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

    invoiceitem1 = invi.find_by_id(1)
    invoiceitem2 = invi.find_by_id(371)

    expect(invoiceitem1.item_id).to eq(263519844)
    expect(invoiceitem2.item_id).to eq(263514300)
  end
end
