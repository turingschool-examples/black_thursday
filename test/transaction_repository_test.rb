require_relative 'simplecov'
SimpleCov.start
require_relative './lib/helper'

RSpec.describe TransactionRepository do
  let!(:sales_engine) {SalesEngine.from_csv({:transactions => "./data/transactions.csv"})}
  let!(:transaction_repo) {sales_engine.transactions}
  let(:new_transaction) {transaction_repo.make_transaction({
    :id => 6,
    :invoice_id => 8,
    :credit_card_number => "4242424242424242",
    :credit_card_expiration_date => "0220",
    :result => "success",
    :created_at => Time.now,
    :updated_at => Time.now
  })}

  it "exists" do
    expect(transaction_repo).to be_instance_of TransactionRepository
  end

  it "can return all transaction instances in an array" do
    expect(transaction_repo.all).to be_a Array
  end

  it "can find transaction by id" do
    new_transaction
    expect(transaction_repo.find_by_id(6)).to be_instance_of Transaction
    expect(transaction_repo.find_by_id(6).invoice_id).to eq(4966)
  end

  it "can find transactions by its invoice id" do
    expect(transaction_repo.find_all_by_invoice_id(4966).first).to be_instance_of Transaction
    expect(transaction_repo.find_all_by_invoice_id(4966).first.id).to eq(6)
  end

  it "can find all transactions by result" do
    new_transaction
    expect(transaction_repo.find_all_by_result("success").first).to be_instance_of Transaction
    expect(transaction_repo.find_all_by_result("success").first.id).to eq(1)
  end

  it "can find all transactions by credit card number" do
    new_transaction
    expect(transaction_repo.find_all_by_credit_card_number("4242424242424242").first).to be_instance_of Transaction
    expect(transaction_repo.find_all_by_credit_card_number("4242424242424242").first.id).to eq(4986)
  end

  xit "can update an transaction" do
    time = Time.now
    new_transaction
    expect(transaction_repo.find_by_id(21831)).to be_instance_of Transaction
    expect(transaction_repo.find_by_id(21831).item_id).to eq(7)
    expect(transaction_repo.find_by_id(21831).quantity).to eq(1)
    # expect(transaction_repo.find_by_id(21831).updated_at.strftime("%Y-%m-%d %H:%M")).to eq(transaction_repo.find_by_id(21831).created_at.strftime("%Y-%m-%d %H:%M"))

    transaction_repo.update(21831, {:quantity => 200, :unit_price => "14.99"})
    expect(transaction_repo.find_by_id(21831).item_id).to eq(7)
    expect(transaction_repo.find_by_id(21831).quantity).to eq(2)
    expect(transaction_repo.find_by_id(21831).unit_price).to eq("14.99")
    # expect(transaction_repo.find_by_id(21831).updated_at).to eq(time.strftime("%Y-%m-%d %H:%M"))
    # expect(transaction_repo.find_by_id(1).updated_at).not_to eq(transaction_repo.find_by_id(21831).created_at)
  end

  it "can delete an transaction" do
    new_transaction
    expect(transaction_repo.find_by_id(4986)).to be_instance_of Transaction
    expect(transaction_repo.find_by_id(4986).invoice_id).to eq(8)
    # expect(transaction_repo.find_by_id(1).updated_at).to eq("2014-03-15")
    invoicerepository = double()
    allow(invoicerepository).to receive(:delete).and_return("Deletion complete!")
  end
end
