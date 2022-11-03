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
  end

  it "#find_all_by_credit_card_number returns all transactions matching given credit card number" do
  end

  it "#find_all_by_result returns all transactions matching given result" do
  end

  it "#create creates a new transaction instance" do
  end

  it "#update updates a transaction" do
  end

  it "#update cannot update id, invoice_id, or created_at" do
  end

  it "#update on unknown transaction does nothing" do
  end
end