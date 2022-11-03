require_relative '../lib/transaction_repository'

RSpec.describe TransactionRepository do
  it 'exists' do
    tr = TransactionRepository.new

    expect(tr).to be_a(TransactionRepository)
  end

  it 'has an empty transactions array by default' do
    tr = TransactionRepository.new

    expect(tr.transactions).to eq([])
  end

  it 'can find by ID, otherwise return nil' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :transactions => "./data/transactions.csv"
      })

    expect(se.transactions.find_by_id(1).id).to eq(se.transactions.all[0].id)
  end
end
