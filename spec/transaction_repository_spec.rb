require_relative '../lib/transaction_repository'
require './lib/sales_engine'
require 'pry'

RSpec.describe TransactionRepository do
  it 'exists' do
    tr = TransactionRepository.new

    expect(tr).to be_a(TransactionRepository)
  end

  it 'has an empty transactions array by default' do
    tr = TransactionRepository.new

    expect(tr.transactions).to eq([])
  end

  it 'returns all transactions' do
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})
    
    expect(se.transactions.all).to be_a(Array)
    expect(se.transactions.all.first).to be_a(Transaction)
  end

  it 'can find by ID, otherwise return nil' do
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})

    expect(se.transactions.find_by_id(1).id).to eq(se.transactions.all[0].id)
    expect(se.transactions.find_by_id(99999999)).to eq(nil)
  end

  it 'can find all by invoice id' do
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})

    expect(se.transactions.find_all_by_invoice_id(2179)).to eq([se.transactions.all[0], se.transactions.all[766]])
    expect(se.transactions.find_all_by_invoice_id(99999999)).to eq([])
    expect(se.transactions.find_all_by_invoice_id(2179)).to be_a(Array)
    expect(se.transactions.find_all_by_invoice_id(2179).first).to be_a(Transaction)
  end

  it 'can find all by credit card number' do
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})

    expect(se.transactions.find_all_by_credit_card_number("4297222478855497")).to eq([se.transactions.all[4]])
    expect(se.transactions.find_all_by_credit_card_number("0000000000000000")).to eq([])
    expect(se.transactions.find_all_by_credit_card_number("4297222478855497")).to be_a(Array)
    expect(se.transactions.find_all_by_credit_card_number("4297222478855497").first).to be_a(Transaction)
  end

  it 'can find all by result' do
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})

    expect(se.transactions.find_all_by_result("success").count).to eq(4158)
    expect(se.transactions.find_all_by_result("failed")[0]).to eq(se.transactions.all[8])
    expect(se.transactions.find_all_by_result("gibberish")).to eq([])
    expect(se.transactions.find_all_by_result("failed")).to be_a(Array)
    expect(se.transactions.find_all_by_result("failed").first).to be_a(Transaction)
  end

  it 'can create new Transaction instances' do
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})

    se.transactions.create({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })

    expect(se.transactions.all.last.credit_card_number).to eq("4242424242424242")
    expect(se.transactions.all.last.id).to eq(4986)
  end

  it 'can update a Transaction instance' do
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv"})

    expect(se.transactions.all[2].credit_card_number).to eq("4271805778010747")
    expect(se.transactions.all[2].result).to eq("success")

    se.transactions.update(3, {
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "failed"
    })

    expect(se.transactions.all[2].credit_card_number).to eq("4242424242424242")
    expect(se.transactions.all[2].result).to eq("failed")
  end
end
