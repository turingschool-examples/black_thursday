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

  it 'can find all transactions by invoice_id' do
    transaction_path = './data/transactions.csv'
    transaction_repository = TransactionRepository.new(transaction_path)
    example_transaction1 = transaction_repository.all[23]
    example_transaction2 = transaction_repository.all[24]

    expect(transaction_repository.find_all_by_invoice_id(3477)).to eq [example_transaction1, example_transaction2]
    expect(transaction_repository.find_all_by_invoice_id(999999)).to eq []
  end

  it 'can find all transactions by credit_card_number' do
    transaction_path = './data/transactions.csv'
    transaction_repository = TransactionRepository.new(transaction_path)
    example_transaction1 = transaction_repository.all[23]

    expect(transaction_repository.find_all_by_credit_card_number(4970472137240748)).to eq [example_transaction1]
    expect(transaction_repository.find_all_by_invoice_id(999999)).to eq []
  end

  it 'can find all transactions by result' do
    transaction_path = './data/transactions.csv'
    transaction_repository = TransactionRepository.new(transaction_path)

    expect(transaction_repository.find_all_by_result("failed").count).to eq 827
    expect(transaction_repository.find_all_by_result("success").count).to eq 4158
  end

  it 'can make a new highest_id' do
    transaction_path = './data/transactions.csv'
    transaction_repository = TransactionRepository.new(transaction_path)

    expect(transaction_repository.new_highest_id).to eq "4986"
  end

  it 'can make a new transaction' do
    transaction_path = './data/transactions.csv'
    transaction_repository = TransactionRepository.new(transaction_path)

    expect(transaction_repository.new_highest_id).to eq "4986"

    transaction_repository.create({
      id: transaction_repository.new_highest_id,
      invoice_id: "111",
      credit_card_number: "1111111111111111",
      credit_card_expiration_date: "1111",
      result: "success",
      created_at: "now",
      updated_at: "just a moment ago"
      })
      
      expect(transaction_repository.new_highest_id).to eq "4987"
      expect(transaction_repository.find_by_id(4986)).not_to eq([])
  end
end
