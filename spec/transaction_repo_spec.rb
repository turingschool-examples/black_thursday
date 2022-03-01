require "./lib/transaction_repo"
require "./lib/merchant_repo"
require "./lib/customer_repo"
require "./lib/invoice_repo"
require "./lib/item_repo"
require "./lib/sales_engine"
require "./lib/transaction"
require "pry"

RSpec.describe TransactionRepository do
  let(:se) do
    SalesEngine.from_csv({
      :items        => "./data/items.csv",
      :merchants    => "./data/merchants.csv",
      :invoices     => "./data/invoices.csv",
      :customers    => "./data/customers.csv",
      :transactions => "./data/transactions.csv"
    })
  end

  let(:tr) do
    TransactionRepository.new("./data/transactions.csv")
  end

  it "is an instance of TransactionRepository" do
    expect(tr).to be_an_instance_of(TransactionRepository)
  end

  it "returns an array of all merchant instances" do
    expect(tr.all.count).to eq 4985
  end

  it "finds a transaction by id" do
    expected_transaction = tr.find_by_id(730)
    expect(expected_transaction.transaction_attributes[:invoice_id]).to eq(3613)
  end

  it "finds all transactions by invoice id" do
    expected_transaction = tr.find_all_by_invoice_id(2850)
    expect(expected_transaction.length).to eq(3)
  end

  it "finds all transactions by cc #" do
    expected_transaction = tr.find_all_by_credit_card_number(4518913442963142)
    expect(expected_transaction.length).to eq(1)
  end

  it "finds all transactions by result" do
    expected_transaction = tr.find_all_by_result("success")
    expect(expected_transaction.length).to eq(4158)
  end

  it "creates a new transaction instance" do
    tr.create({invoice_id: 9999})
    expected_transaction = tr.find_by_id(4986)
    expect(expected_transaction.transaction_attributes[:invoice_id]).to eq(9999)
  end

  it "updates a transaction" do
    tr.create({invoice_id: 9999})
    tr.update(4986, {credit_card_number: 4000999999999999})
    expected_transaction = tr.find_by_id(4986)
    expect(expected_transaction.transaction_attributes[:credit_card_number]).to eq(4000999999999999)
  end

  it "deletes a transaction" do
    tr.create({invoice_id: 9999})
    tr.delete(4986)
    expect(tr.find_by_id(4986)).to eq nil
  end
end
