require './lib/transaction_repository'
require './lib/sales_engine'

RSpec.describe TransactionRepository do
  it 'exists' do
    sales_engine = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: "./data/transactions.csv"})
    transaction = sales_engine.transactions.find_by_id(6)
    expect(transaction.id).to eq(6)
  end

  it '#all' do
  expect(transactions.all).to be_a(Array)
end
end