require_relative '../lib/transaction_repository'
require './lib/sales_engine'
require "spec_helper_2"
require 'pry'

RSpec.describe TransactionRepository do
  it 'exists' do

    expect(engine.transactions).to be_a(TransactionRepository)
  end

  it 'returns all transactions' do
    expect(engine.transactions.all).to be_a(Array)
    expect(engine.transactions.all.first).to be_a(Transaction)
  end

  it 'can find by ID, otherwise return nil' do
    expect(engine.transactions.find_by_id(1).id).to eq(engine.transactions.all[0].id)
    expect(engine.transactions.find_by_id(99999999)).to eq(nil)
  end

  it 'can find all by invoice id' do
    expect(engine.transactions.find_all_by_invoice_id(2179)).to eq([engine.transactions.all[0], engine.transactions.all[766]])
    expect(engine.transactions.find_all_by_invoice_id(99999999)).to eq([])
    expect(engine.transactions.find_all_by_invoice_id(2179)).to be_a(Array)
    expect(engine.transactions.find_all_by_invoice_id(2179).first).to be_a(Transaction)
  end

  it 'can find all by credit card number' do
    expect(engine.transactions.find_all_by_credit_card_number("4297222478855497")).to eq([engine.transactions.all[4]])
    expect(engine.transactions.find_all_by_credit_card_number("0000000000000000")).to eq([])
    expect(engine.transactions.find_all_by_credit_card_number("4297222478855497")).to be_a(Array)
    expect(engine.transactions.find_all_by_credit_card_number("4297222478855497").first).to be_a(Transaction)
  end

  it 'can find all by result' do
    expect(engine.transactions.find_all_by_result(:success).count).to eq(4158)
    expect(engine.transactions.find_all_by_result(:failed)[0]).to eq(engine.transactions.all[8])
    expect(engine.transactions.find_all_by_result(:gibberish)).to eq([])
    expect(engine.transactions.find_all_by_result(:failed)).to be_a(Array)
    expect(engine.transactions.find_all_by_result(:failed).first).to be_a(Transaction)
  end

  it 'can create new Transaction instances' do
    engine.transactions.create({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => :success,
      :created_at => Time.now,
      :updated_at => Time.now
    })

    expect(engine.transactions.all.last.credit_card_number).to eq("4242424242424242")
    expect(engine.transactions.all.last.id).to eq(4986)
  end

  it 'can update a Transaction instance' do
    expect(engine.transactions.all[2].credit_card_number).to eq("4271805778010747")
    expect(engine.transactions.all[2].result).to eq(:success)
    engine.transactions.update(3, {
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => :failed
    })

    expect(engine.transactions.all[2].credit_card_number).to eq("4242424242424242")
    expect(engine.transactions.all[2].result).to eq(:failed)
  end

  it 'can delete a Transaction instance' do
    expect(engine.transactions.all.last.credit_card_number).to eq("4242424242424242")
    expect(engine.transactions.all.last.result).to eq(:success)

    engine.transactions.delete(6)

    expect(engine.transactions.find_by_id(6)).to eq(nil)
  end
end
