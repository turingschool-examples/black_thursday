require './lib/transaction'
require'./lib/transaction_repository'

RSpec.describe TransactionRepository do
  let(:transaction_repository) {TransactionRepository.new}
  let(:transaction) {Transaction.new({
    :id => 6, 
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date  => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
  })}

  it 'exists' do
    expect(transaction_repository).to be_a(TransactionRepository)
  end

  it "#find_all_by_invoice_id returns all transactions matching the given id" do
    expect(transaction_repository.find_all_by_invoice_id(5)).to eq nil
    expect(transaction_repository.find_all_by_invoice_id(8)).to eq (transaction)
  end

  it "#find_all_by_credit_card_number returns all transactions matching given credit card number" do
    expect(transaction_repository.find_all_by_credit_card_number("4242424242423333")).to eq nil
    expect(transaction_repository.find_all_by_credit_card_number("4242424242424242")).to eq (transaction)
  end

  it "#find_all_by_result returns all transactions matching given result" do
    expect(transaction_repository.find_all_by_result("failed")).to eq nil
    expect(transaction_repository.find_all_by_result("success")).to eq (transaction)
  end

  it "#create creates a new transaction instance" do
    expect(transaction_repository.create({Transaction.new({
      :id => 6, 
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date  => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })})).to eq (transaction)
  end

  it "#update updates a transaction" do
  end

  it "#update cannot update id, invoice_id, or created_at" do
  end

  it "#update on unknown transaction does nothing" do
  end
end