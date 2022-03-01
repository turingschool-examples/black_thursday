# Transaction Test spec
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_engine'
require 'pry'

RSpec.describe 'Iteration 3' do
  context 'Transactions' do
    before(:each) do
      @se = SalesEngine.from_csv({
                                   items: './data/items.csv',
                                   merchants: './data/merchants.csv',
                                   invoices: './data/invoices.csv',
                                   transactions: './data/transactions.csv'
                                 })
    end

    it '#all returns all transactions' do
      expected = @se.transactions.all
      expect(expected.count).to eq 4985
    end

    it '#find_by_id returns a transaction matching the given id' do
      id = 2
      expected = @se.transactions.find_by_id(id)

      expect(expected.id).to eq(id)
      expect(expected.class).to eq(Transaction)
    end

    it '#find_all_by_invoice_id returns all transactions matching the given id' do
      id = 419
      expected = @se.transactions.find_all_by_invoice_id(id)

      expect(expected.length).to eq 1

      expect(expected.first.invoice_id).to eq id
      expect(expected.first.class).to eq Transaction

      id = 194_345
      expected = @se.transactions.find_all_by_invoice_id(id)
      expect(expected.empty?).to eq true
    end

    it '#find_all_by_credit_card_number returns all transactions matching given credit card number' do
      credit_card_number = '4970472137240748'
      expected = engine.transactions.find_all_by_credit_card_number(credit_card_number)

      expect(expected.length).to eq 1
      expect(expected.first.class).to eq Transaction
      expect(expected.first.credit_card_number).to eq credit_card_number

      credit_card_number = '4848466917766328'
      expected = engine.transactions.find_all_by_credit_card_number(credit_card_number)

      expect(expected.empty?).to eq true
    end
  end
end
