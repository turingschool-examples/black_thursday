require 'CSV'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/merchant'
require './lib/item'
require './lib/item_repo'
# require './lib/invoice_item'
# require './lib/invoice_item_repo'
require './lib/transaction'
require 'bigdecimal'

RSpec.describe ItemRepo do
  describe 'instantiation' do
    before(:each) do
      # @repo = SalesEngine.from_csv({:items => "./data/items.csv",
      #                               :merchants => "./data/merchants.csv"})
      @repo = SalesEngine.from_csv(:transactions => "./data/transactions.csv")
    end

    it '::new' do
      transaction_repo = TransactionRepo.new("./data/transactions.csv", @repo)

      expect(transaction_repo).to be_an_instance_of(TransactionRepo)
    end

    it 'has attributes' do
      transaction_repo = TransactionRepo.new("./data/transactions.csv", @repo)

      expect(transaction_repo.transactions).to be_an_instance_of(Array)
    end
  end

  describe '#methods' do

    it '#all' do
      item_repo = ItemRepo.new("./data/items.csv",@repo)

      expect(item_repo.all).to be_an_instance_of(Array)
    end

end
