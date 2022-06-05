require_relative './spec_helper'

RSpec.describe TransactionRepository do
  before :each do
    @transaction_repository = TransactionRepository.new("./data/transactions.csv")
  end

  it 'is an instance of TransactionRepository' do
    expect(@transaction_repository).to be_instance_of(TransactionRepository)
  end

  it 'has an array of Transactions' do
    expect(@transaction_repository.all[0].class).to eq(Transaction)
    expect(@transaction_repository.all.class).to eq(Array)
    expect(@transaction_repository.all.count).to eq(4985)
  end

  it 'can find by id' do
    expect(@transaction_repository.find_by_id(2).class).to eq(Transaction)
  end

  it 'can find all by Invoice id' do
    expect(@transaction_repository.find_all_by_invoice_id(2179).length).to eq(2)
  end

  it 'can find all by credit card number' do
    expect(@transaction_repository.find_all_by_credit_card_number("4848466917766329").length).to eq(1)
  end

  it 'can find all by result' do
    expect(@transaction_repository.find_all_by_result(:success).length).to eq(4158)
    expect(@transaction_repository.find_all_by_result(:success)[0].class).to eq(Transaction)
  end

  it 'can create a new Transaction' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @transaction_repository.create(attributes)
    expect(@transaction_repository.find_by_id(4986).invoice_id).to eq(8)
  end

  it 'can create new attributes for a Transaction' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @transaction_repository.create(attributes)
    original_time = @transaction_repository.find_by_id(4986).updated_at
    updates = {result: :failed}
    @transaction_repository.update(4986, updates)
    expect(@transaction_repository.find_by_id(4986).result).to eq(:failed)
    expect(@transaction_repository.find_by_id(4986).credit_card_expiration_date).to eq("0220")
    expect(@transaction_repository.find_by_id(4986).updated_at).to be > original_time

    update_fail = {invoice_id: 10}
    expect(@transaction_repository.update(4986, update_fail)).to eq(nil)
  end

  it 'can delete an instance of a Transaction' do
    attributes = {
        :invoice_id => 8,
        :credit_card_number => "4242424242424242",
        :credit_card_expiration_date => "0220",
        :result => "success",
        :created_at => Time.now,
        :updated_at => Time.now
      }
    @transaction_repository.create(attributes)

    @transaction_repository.delete(4986)
    expect(@transaction_repository.find_by_id(4986)).to eq(nil)
  end
end
