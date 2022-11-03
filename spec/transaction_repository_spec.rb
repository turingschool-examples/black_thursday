require_relative '../lib/transaction_repository'
require './lib/sales_engine'

RSpec.describe TransactionRepository do
  it 'exists' do
    tr = TransactionRepository.new

    expect(tr).to be_a(TransactionRepository)
  end

  it 'has an empty transactions array by default' do
    tr = TransactionRepository.new

    expect(tr.transactions).to eq([])
  end

  it 'returns all transactions' do
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})
    
    expect(se.transactions.all).to be_a(Array)
    expect(se.transactions.all.first).to be_a(Transaction)
  end

  it 'can find by ID, otherwise return nil' do
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})

    expect(se.transactions.find_by_id(1).id).to eq(se.transactions.all[0].id)
  end

  it 'can find all by invoice id' do
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})

    expect(se.transactions.find_all_by_invoice_id(2179)).to eq([se.transactions.all[0], se.transactions.all[766]])
    expect(se.transactions.find_all_by_invoice_id(2179).first).to be_a(Transaction)
  end
end
