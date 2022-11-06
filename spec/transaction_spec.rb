# frozen_string_literal: true

require './lib/transaction'

describe Transaction do
  before(:each) do
    @transaction = {
      id:                          6,
      invoice_id:                  8,
      credit_card_number:          '4242424242424242',
      credit_card_expiration_date: '0220',
      result:                      :success,
      created_at:                  Time.now,
      updated_at:                  Time.now
    }

    @ir = ''
    @transaction = Transaction.new(@transaction, @ir)
  end

  describe '#initialization' do
    it 'exists' do
      expect(@transaction).to be_instance_of(Transaction)
    end
  end

  describe '#getters' do
    it 'returns transaction id' do
      expect(@transaction.id).to eq(6)
    end

    it 'returns transaction invoice_id' do
      expect(@transaction.invoice_id).to eq(8)
    end

    it 'returns transaction credit card number' do
      expect(@transaction.credit_card_number).to eq('4242424242424242')
    end

    it 'returns transaction credit_card_expiration_date' do
      expect(@transaction.credit_card_expiration_date).to eq('0220')
    end

    it 'returns transaction result' do
      expect(@transaction.result).to eq('success')
    end
  end

  describe '#created_at' do
    it 'returns transaction creation date' do
      expect(@transaction.created_at).to be_instance_of(Time)
    end
  end

  describe '#updated_at' do
    it 'returns transaction updated date' do
      expect(@transaction.updated_at).to be_instance_of(Time)
    end
  end

  describe '#update' do
    it 'Updates the attributes of an item based on passed values' do
      @transaction.update(credit_card_number: '4242424242425555',
         credit_card_expiration_date: '0125')
      expect(@transaction.credit_card_number).to eq('4242424242425555')
      expect(@transaction.credit_card_expiration_date).to eq('0125')
      expect(@transaction.result).to eq('success')
    end
  end
end
