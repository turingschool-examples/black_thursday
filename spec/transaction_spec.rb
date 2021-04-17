require 'rspec'
require './lib/transaction'

describe Transaction do
  describe '#initialize' do
    it 'exists' do
      details = {
        id: 6,
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }

      transaction = Transaction.new(details)

      expect(transaction).is_a? Transaction
    end

    it 'has an id' do
      details = {
        id: 6,
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }

      transaction = Transaction.new(details)

      expect(transaction.id).to eq 6
    end

    it 'has an invoice id' do
      details = {
        id: 6,
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }

      transaction = Transaction.new(details)

      expect(transaction.invoice_id).to eq 8
    end

    it 'has a credit card number' do
      details = {
        id: 6,
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }

      transaction = Transaction.new(details)

      expect(transaction.credit_card_number).to eq '4242424242424242'
    end

    it 'has a credit card expiration date' do
      details = {
        id: 6,
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }

      transaction = Transaction.new(details)

      expect(transaction.credit_card_expiration_date).to eq '0220'
    end

    it 'returns the result as a symbol' do
      details = {
        id: 6,
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }

      transaction = Transaction.new(details)

      expect(transaction.result).to eq :success
    end

    it 'returns time objects for created and updated at' do
      details = {
        id: 6,
        invoice_id: 8,
        credit_card_number: '4242424242424242',
        credit_card_expiration_date: '0220',
        result: 'success',
        created_at: Time.now,
        updated_at: Time.now
      }

      transaction = Transaction.new(details)

      expect(transaction.created_at).is_a? Time
      expect(transaction.updated_at).is_a? Time
    end
  end
end
