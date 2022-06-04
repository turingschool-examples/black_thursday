require './lib/transaction_repository'

RSpec.describe TransactionRepository do
  before :each do
    @tr = TransactionRepository.new('./data/transactions.csv')
  end

  it "exists" do
    expect(@tr).to be_a(TransactionRepository)
  end

  it "has all" do
    expect(@tr.all).to be_a(Array)
    expect(@tr.all).to include(Transaction)
  end

end
