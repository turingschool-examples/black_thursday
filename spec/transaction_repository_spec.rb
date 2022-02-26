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




end
