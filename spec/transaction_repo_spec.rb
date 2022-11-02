# frozen_string_literal: true

require './lib/transaction'
require './lib/transaction_repo'
require 'bigdecimal'
require 'CSV'

describe TransactionRepo do
  before(:each) do
    csv = {:transactions => './data/transactions.csv'}.values[0]
    @stats = CSV.readlines(csv, headers: true, header_converters: :symbol)
    @stats = @stats[0..4]
    @tr = TransactionRepo.new(@stats)
    @transaction1 = @tr.all[0]
    @transaction2 = @tr.all[1]
    @transaction3 = @tr.all[2]
    @transaction4 = @tr.all[3]
    @transaction5 = @tr.all[4]
  end

  describe '#initialization' do
    it 'exists' do
      expect(@tr).to be_instance_of(TransactionRepo)
    end
  end

  describe '#create' do
    it 'creates an item based on the values passed in' do
      @tr.create(
        id:                          6,
        invoice_id:                  8,
        credit_card_number:          '4242424242424242',
        credit_card_expiration_date: '0220',
        result:                      'success',
        created_at:                  Time.now,
        updated_at:                  Time.now
      )

      expect(@tr.all.last.result).to eq('success')
    end
  end

  describe '#all' do
    it 'returns list of all added items' do
      expect(@tr.all).to eq([@transaction1, @transaction2, @transaction3, @transaction4, @transaction5])
    end
  end

  describe '#find_by_id' do
    it 'searches for specific item id and returns invoice or nil if empty' do
      expect(@tr.find_by_id(1)).to eq(@transaction1)
      expect(@tr.find_by_id(10)).to eq(nil)
    end
  end

  describe '#find_all_by_invoice_id' do
    it 'searches for specific invoice id and returns invoices or empty array' do
      expect(@tr.find_all_by_invoice_id(46)).to eq([@transaction2])
      expect(@tr.find_all_by_invoice_id(22)).to eq([])
    end
  end

  describe '#find_all_by_credit_card_number' do
    it 'searches for card number and returns invoices found or empty array' do
      expect(@tr.find_all_by_credit_card_number('4048033451067370')).to eq([@transaction4])
      expect(@tr.find_all_by_credit_card_number('4048033451067366')).to eq([])
    end
  end

  describe '#find_all_by_result' do
    it 'searches for result and returns invoices found or empty array' do
      expect(@tr.find_all_by_result('success')).to eq([@transaction1, @transaction2, @transaction3, @transaction4, @transaction5])
      expect(@tr.find_all_by_result('failure')).to eq([])
    end
  end

  describe '#update' do
    it 'updates the values of the item at id with attributes passed in' do
      @tr.update(1,{ result: 'failure', credit_card_number: '4048033451067366'})
      expect(@transaction1.result).to eq('failure')
      expect(@transaction1.credit_card_number).to eq('4048033451067366')
    end
  end

  describe '#delete' do
    it 'deletes the item at the specified id index' do
      @tr.delete(1)
      expect(@tr.all).to eq([@transaction2, @transaction3, @transaction4, @transaction5])
    end
  end
end
