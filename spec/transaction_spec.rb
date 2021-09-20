# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'rspec'
require './lib/transaction'

describe Transaction do
  before(:each) do
    @transaction_info = {
      id: 6,
      invoice_id: 8,
      credit_card_number: '4242424242424242',
      credit_card_expiration_date: '0220',
      result: 'success',
      created_at: Time.now,
      updated_at: Time.now
    }
    @t = Transaction.new(@transaction_info)
  end

  it 'is an instance of Transaction' do
    expect(@t).to be_a(Transaction)
  end

  describe '#id' do
    it 'returns the integer id' do
      expect(@t.id).to eq(6)
    end
  end

  describe '#invoice_id' do
    it 'returns the invoice id' do
      expect(@t.invoice_id).to eq(8)
    end
  end

  describe '#credit card number' do
    it 'returns the credit card number' do
      expect(@t.cc_num).to eq('4242424242424242')
    end
  end

  describe '#credit card expiration date' do
    it 'returns the credit card expiration date' do
      expect(@t.cc_exp).to eq('0220')
    end
  end

  describe '#result' do
    it 'returns the result' do
      expect(@t.result).to eq('success')
    end
  end

  describe '#created_at' do
    it 'returns the time that the transaction was created' do
      expect(@t.created_at).to eq(@transaction_info[:created_at])
    end
  end

  describe '#updated_at' do
    it 'returns the time that the transaction was last updated' do
      expect(@t.updated_at).to eq(@transaction_info[:updated_at])
    end
  end

  describe '#update' do
    it 'updates all information based on given input' do
      attributes = {
        cc_num: 432_123_456_765_432_1,
        cc_exp: 1223,
        result: 'success'
      }
      @t.update(attributes)

      expect(@t.cc_num).to eq(432_123_456_765_432_1)
      expect(@t.cc_exp).to eq(1223)
      expect(@t.result).to eq('success')
    end
  end
end
