require './lib/transaction_repository'

RSpec.describe TransactionRepository do
  before :each do
    @tr = TransactionRepository.new('./data/transactions.csv')
  end

  it "exists" do
    expect(@tr).to be_a(TransactionRepository)
  end

end
