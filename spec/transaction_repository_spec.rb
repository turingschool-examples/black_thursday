require 'pry'
require 'rspec'
require 'simplecov'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/transaction'

SimpleCov.start

RSpec.describe TransactionRepository do
  it 'exists' do
    tr = TransactionRepository.new([])
    expect(tr).to be_a(TransactionRepository)
  end

  it 'returns an array of all Transaction Instances' do
    tr = TransactionRepository.new([])
    expect(tr.all).to eq([])
  end

  it 'can find a transaction by id' do
    t = Transaction.new({
                          :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                        })
    tr = TransactionRepository.new([t])
    # binding.pry
    # expect(tr.find_by_id(7)).to eq(nil)
    expect(tr.find_by_id(6)).to eq(t)
  end

  it 'can find an array of transactions by invoice id' do
    t = Transaction.new({
                          :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                        })
    tr = TransactionRepository.new([t])
    expect(tr.find_all_by_invoice_id(7)).to eq([])
    expect(tr.find_all_by_invoice_id(8)).to eq([t])
  end

  xit 'can find an array of transactions by cc number' do
    t = Transaction.new({
                          :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                        })
    tr = TransactionRepository.new([t])
    expect(tr.find_all_by_credit_card_number("5747635673574567")).to eq([])
    expect(tr.find_all_by_credit_card_number("4242424242424242")).to eq([t])
  end

  xit 'can find an array of transactions by result' do
    t = Transaction.new({
                          :id => 6,
                          :invoice_id => 8,
                          :credit_card_number => "4242424242424242",
                          :credit_card_expiration_date => "0220",
                          :result => "success",
                          :created_at => Time.now,
                          :updated_at => Time.now
                        })
    tr = TransactionRepository.new([t])
    expect(tr.find_all_by_result("failure")).to eq([])
    expect(tr.find_all_by_result("success")).to eq([t])
  end

  xit 'can create a new transaction with the highest transaction id' do
  end

  xit 'can delete a transaction with the corresponding id' do
  end
end
