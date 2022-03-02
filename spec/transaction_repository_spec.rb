# frozen_string_literal: true

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
                                   transactions: './data/transactions.csv',
                                   customers: './data/customers.csv',
                                   invoice_items: './data/invoice_items.csv'
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

      expect(expected.length).to eq(1)

      expect(expected.first.invoice_id).to eq(id)
      expect(expected.first.class).to eq(Transaction)

      id = 194_345
      expected = @se.transactions.find_all_by_invoice_id(id)
      expect(expected.empty?).to eq(true)
    end

    it '#find_all_by_credit_card_number returns all transactions matching given credit card number' do
      credit_card_number = '4970472137240748'
      expected = @se.transactions.find_all_by_credit_card_number(credit_card_number)

      expect(expected.length).to eq(1)
      expect(expected.first.class).to eq(Transaction)
      expect(expected.first.credit_card_number).to eq(credit_card_number)

      credit_card_number = '4848466917766328'
      expected = @se.transactions.find_all_by_credit_card_number(credit_card_number)

      expect(expected.empty?).to eq(true)
    end

    it '#find_all_by_result returns all transactions matching given result' do
      result = :success
      expected = @se.transactions.find_all_by_result(result)

      expect(expected.length).to eq(4158)
      expect(expected.first.class).to eq(Transaction)
      expect(expected.first.result).to eq(result)

      result = :failed
      expected = @se.transactions.find_all_by_result(result)

      expect(expected.length).to eq(827)
      expect(expected.first.class).to eq(Transaction)
      expect(expected.first.result).to eq(result)
    end

    it '#create creates a new transaction instance' do
      attributes = {
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.transactions.create(attributes)
      expected = @se.transactions.find_by_id(4986)
      expect(expected.invoice_id).to eq 8
    end

    it '#update updates a transaction' do
      attributes = {
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.transactions.create(attributes)

      original_time = @se.transactions.find_by_id(4986).updated_at
      attributes = {
        result: :failed
      }
      @se.transactions.update(4986, attributes)
      expected = @se.transactions.find_by_id(4986)
      expect(expected.result).to eq :failed
      expect(expected.credit_card_expiration_date).to eq '0220'
      expect(expected.updated_at).to be > original_time
    end

    it '#update cannot update id, invoice_id, or created_at' do
      attributes = {
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.transactions.create(attributes)

      attributes = {
        id: 5000,
        invoice_id: 2,
        created_at: Time.now
      }
      @se.transactions.update(4986, attributes)
      expected = @se.transactions.find_by_id(5000)
      expect(expected).to eq nil
      expected = @se.transactions.find_by_id(4986)
      expect(expected.invoice_id).not_to eq attributes[:invoice_id]
      expect(expected.created_at).not_to eq attributes[:created_at]
    end

    it '#update on unknown transaction does nothing' do
      @se.transactions.update(5000, {})
    end

    it '#delete deletes the specified transaction' do
      attributes = {
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }
      @se.transactions.create(attributes)

      @se.transactions.delete(4986)
      expected = @se.transactions.find_by_id(4986)
      expect(expected).to eq nil
    end

    it '#delete on unknown customer does nothing' do
      @se.customers.delete(2000)
    end

    it 'can test the #inspect method workaround' do
      expect(@transactions.inspect).to be_a(String)
    end

  end
end
