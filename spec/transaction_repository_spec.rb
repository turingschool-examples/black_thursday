require './lib/transation_repository'
require '.'

RSpec.describe TransactionRepository do
  it 'exists' do
    sales_engine = SalesEngine.from_csv(:transactions => "./data/transactions.csv")
    transaction = sales_engine.transactions.find_by_id(6)
    expect(transaction.id).to eq(6)
  end
end