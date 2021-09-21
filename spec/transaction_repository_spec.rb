require './lib/transaction_repository'
require './lib/transaction'
require 'csv'

RSpec.describe do

  it 'exists' do
    transaction_path = './data/transactions.csv'
    transaction_repository = TransactionRepository.new(transaction_path)
    expect(transaction_repository).to be_an_instance_of(TransactionRepository)
  end

  it 'can return an array of all known transactions' do
    transaction_path = './data/transactions.csv'
    transaction_repository = TransactionRepository.new(transaction_path)
    expect(transaction_repository.all[0]).to be_an_instance_of(Transaction)
    expect(transaction_repository.all.count).to eq 4985
  end

  it 'can find transaction by id' do
    transaction_path = './data/transactions.csv'
    transaction_repository = TransactionRepository.new(transaction_path)
    example_transaction = transaction_repository.all[25]
    
    expect(transaction_repository.find_by_id(example_transaction.id)).to eq example_transaction
    expect(transaction_repository.find_by_id(999999)).to eq nil
  end
end





# t = Transaction.new({
#   :id => 6,
#   :invoice_id => 8,
#   :credit_card_number => "4242424242424242",
#   :credit_card_expiration_date => "0220",
#   :result => "success",
#   :created_at => Time.now,
#   :updated_at => Time.now
