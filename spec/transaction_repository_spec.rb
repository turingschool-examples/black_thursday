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

  it "can find_by_id" do
    expect(@tr.find_by_id(1)).to be_a(Transaction)
    expect(@tr.find_by_id(4987)).to be_nil
  end

end
