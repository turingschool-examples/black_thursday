# Transaction Test spec
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'
require 'pry'

RSpec.describe 'Iteration 3' do
  context 'Invoices' do
    before(:each) do
      @se = SalesEngine.from_csv({
                                   items: './data/items.csv',
                                   merchants: './data/merchants.csv',
                                   invoices: './data/invoices.csv'
                                   transactions: './data/transactions.csv'
                                 })
    end

    it "#all returns all transactions" do
      expected = @se.transactions.all
      expect(expected.count).to eq 4985
    end

  end
end