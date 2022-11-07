require './lib/transaction_repository'
require './lib/sales_engine'

RSpec.describe TransactionRepository do
    let(:sales_engine) {
        SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: "./data/transactions.csv"})
    }
  it 'exists' do
    transaction = sales_engine.transactions.find_by_id(6)
    expect(transaction.id).to eq(6)
  end

  it '#all' do
  expect(sales_engine.transactions.all).to be_a(Array)
end
end