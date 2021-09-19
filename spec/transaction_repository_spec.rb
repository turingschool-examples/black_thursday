# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'rspec'
require './lib/transaction'
require './lib/transaction_repository'

describe TransactionRepository do
  before(:each) do
    @tr = TransactionRepository.new('./data/transactions.csv')
  end

  it 'is an instance of a TransactionRepository' do
    expect(@tr).to be_a(TransactionRepository)
  end

  describe '#all' do
    it 'returns a full array of transactions' do
      expect(@tr.all).to be_a(Array)
      @tr.all.each do |transaction|
        expect(transaction).to be_a(Transaction)
      end
    end
  end

  describe '#find_by_id' do
    it 'returns the transaction with given id, or nil otherwise' do
      expect(@tr.find_by_id(16)).to eq(@tr.all[15])
      expect(@tr.find_by_id(642_351)).to be nil
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'returns all transactions with matching invoice id in an array' do
      expect(@tr.find_all_by_invoice_id('1752')).to include(@tr.all[8], @tr.all[4619])
      expect(@tr.find_all_by_invoice_id('745_362')).to eq([])
    end
  end

  describe '#find_all_by_credit_card_number' do
    it 'returns all transactions with matching credit card # in an array' do
      card_number = 489_037_127_963_277_5
      expect(@tr.find_all_by_credit_card_number(card_number)).to include(@tr.all[19])
      expect(@tr.find_all_by_credit_card_number(532_723_123)).to eq([])
    end
  end

  describe '#find_all_by_result' do
    it 'returns all transactions with matching result in an array' do
      expect(@tr.find_all_by_result('success')).to include(@tr.all[12], @tr.all[14])
      expect(@tr.find_all_by_result('see you later')).to eq([])
    end
  end

  describe '#create' do
    it 'creates a new instance of a transaction with given attributes' do
      new_transaction = {
        invoice_id: 3245,
        credit_card_number: 123_456_789_012_131_4,
        credit_card_expiration_date: 0227,
        status: 'pending'
      }
      @tr.create(new_transaction)

      expect(@tr.all.last).to be_a(Transaction)
      expect(@tr.all.last.invoice_id).to eq(3245)
      expect(@tr.all.last.result).to eq('pending')
    end
  end

  describe '#update' do
    it 'updates a transaction credit card number/expiriation date/result' do
      info = {
        credit_card_number: 543_265_437_654_876_5,
        credit_card_expiration_date: 1223,
        result: 'failed'
      }
      expect(@tr.update(2, info)).to eq(@tr.all[1])
    end
  end

  describe '#delete' do
    it 'removes the transaction with the given id' do
      deleted_transaction = @tr.all[4]
      expect(@tr.delete(5)).to eq(deleted_transaction)
      expect(@tr.find_by_id(5)).to be nil
    end
  end
end
