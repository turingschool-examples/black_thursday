require 'CSV'
require 'transaction'
require 'transaction_repository'

RSpec.describe TransactionRepository do
  before :each do
    @transaction_repository = TransactionRepository.new("./data/transactions.csv")
  end

  it "exists" do
    expect(@transaction_repository).to be_a TransactionRepository
  end

  it "returns an array of all known Transaction instances" do
    expect(@transaction_repository.all).to be_a Array
    expect(@transaction_repository.all.length).to eq(4985)
    expect(@transaction_repository.all.first.id).to eq("1")
    expect(@transaction_repository.all.first.invoice_id).to eq("2179")
  end

  it "can find by id" do
    expect(@transaction_repository.find_by_id(0)).to eq nil
    expect(@transaction_repository.find_by_id(1).invoice_id).to eq("2179")
  end

  it "find all by invoice id" do
    expect(@transaction_repository.find_all_by_invoice_id(0)).to eq ([])
    expect(@transaction_repository.find_all_by_invoice_id(2179).first).to be_a Transaction
    expect(@transaction_repository.find_all_by_invoice_id(2179).first.id).to eq("1")
  end

  it "find all by credit card number" do
    expect(@transaction_repository.find_all_by_credit_card_number(2833442)).to eq([])
    expect(@transaction_repository.find_all_by_credit_card_number(4068631943231473).first.id).to eq("1")
    expect(@transaction_repository.find_all_by_credit_card_number(4068631943231473).first).to be_a Transaction
  end

  it "find all by result" do
    expect(@transaction_repository.find_all_by_result("fail")).to eq([])
    expect(@transaction_repository.find_all_by_result("success").first.id).to eq("1")
    expect(@transaction_repository.find_all_by_result("failed").first.id).to eq("9")
    expect(@transaction_repository.find_all_by_result("failed").first).to be_a Transaction
  end

  it "can create a new Transaction instance" do
    expect(@transaction_repository.all.last.id).to eq("4985")
    @transaction_repository.create({:id => 1, :invoice_id => 3734, :credit_card_number => 0000000000000001, :credit_card_expiration_date => 1010, :result => "success", :created_at => Time.now, :updated_at => Time.now})
    expect(@transaction_repository.all.last.id).to eq(4986)
    expect(@transaction_repository.all.last).to be_a Transaction
  end

  it "can update the Transaction instance with the corresponding id" do
    @transaction_repository.update(1,{:id => 1,:credit_card_number => 0000000000000001, :credit_card_expiration_date => 1010,})
    expect(@transaction_repository.all.first.credit_card_number).to eq(0000000000000001)
    expect(@transaction_repository.all.first.credit_card_expiration_date).to eq(1010)
    expect(@transaction_repository.all.last).to be_a Transaction
  end

  it "delete the Transaction instance with the corresponding id" do
    expect(@transaction_repository.all.first.invoice_id).to eq("2179")
    @transaction_repository.delete(1)
    expect(@transaction_repository.all.first.invoice_id).to eq("46")
    expect(@transaction_repository.all.last).to be_a Transaction
  end
end
