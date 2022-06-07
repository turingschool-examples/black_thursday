require './lib/item.rb'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/transaction'
require './lib/transaction_repository'
require 'CSV'

RSpec.describe TransactionRepository do

  it "exists" do
    transaction_repository = TransactionRepository.new("./data/transactions.csv")
    expect(transaction_repository).to be_instance_of(TransactionRepository)
  end
end
