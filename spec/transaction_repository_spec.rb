require './lib/transaction_repository'
require './lib/sales_engine'

RSpec.describe TransactionRepository do
    let(:transactions) { 
        # sales_engine =
        SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: "./data/transactions.csv"}).transactions

    }
    
  it 'exists' do
    transaction = transactions.find_by_id(6)
    expect(transaction.id).to eq(6)
  end

  it '#all' do
    expect(transactions.all).to be_a(Array)
  end

  it '#find_by_id' do
  expect(transactions.find_by_id(0)).to eq(nil)
  expect(transactions.find_by_id(4)).to be_instance_of(Transaction)
  
end

  it '#find_all_by_invoice_id' do
    expect(transactions.find_all_by_invoice_id(0)).to eq([]) 
  end

  it '#find_all_by_credit_card_number' do
    expect(transactions.find_all_by_credit_card_number(444)).to eq([])
  end

  it '#find_all_by_result' do
  expect(transactions.find_all_by_result("success")).to be_a(Array)
end

it '#create makes new transaction' do
 transaction = transactions.create({
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
  })
  expect(transaction).to be_instance_of(Transaction)
  expect(transaction.id).to be > transactions.all[-2].id
end

it '#delete' do
expect(transactions.find_by_id(1)).to be_a(Transaction)
transactions.delete(1)
expect(transactions.find_by_id(1)).to eq([])
end
end