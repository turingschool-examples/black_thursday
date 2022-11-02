# frozen_string_literal: true

require './lib/transaction'
require './lib/transaction_repo'
require 'bigdecimal'
require 'CSV'

describe TransactionRepo do
  before(:each) do
    csv = {:transactions => './data/items.csv'}.values[0]
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
    it 'searches for specific item id and returns item or nil if empty' do
      expect(@tr.find_by_id(263395237)).to eq(@transaction1)
      expect(@tr.find_by_id(263395537)).to eq(nil)
    end
  end

  describe '#find_by_name' do
    it 'searches for specific name and returns item or nil' do
      expect(@tr.find_by_name('Glitter scrabble frames')).to eq(@transaction2)
      expect(@tr.find_by_name('Glitter scrabble')).to eq(nil)
    end
  end

  describe '#clean_string' do
    it 'returns a string after removing spaces and newline characters' do
      unclean = "Free standing wooden\n letters \n15cm Any colours\n"
      cleaned = "Freestandingwoodenletters15cmAnycolours"
      expect(@tr.clean_string(unclean)).to eq(cleaned)
    end
  end

  describe '#find_by_description' do
    it 'searches for specific description and returns items found or empty array' do
      description = "Free standing wooden\n letters \n15cm Any colours\n"
      expect(@tr.find_by_description(description)).to eq([@transaction4])
      expect(@tr.find_by_description("Free standing wooden\n letters")).to eq([])
    end
  end

  describe '#find_all_by_price' do
    it 'searches for specific price and returns items' do
      expect(@tr.find_all_by_price(1300)).to eq([@transaction2])
      expect(@tr.find_all_by_price(1000)).to eq([])
    end
  end

  describe '#find_all_by_price_range' do
    it 'searches for specific price range and returns items' do
      expect(@tr.find_all_by_price_range(1000..1400)).to eq([@transaction1, @transaction2, @transaction3])
      expect(@tr.find_all_by_price_range(10..100)).to eq([])
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'searches for merchant id and returns items' do
      expect(@tr.find_all_by_merchant_id(12334141)).to eq([@transaction1])
      expect(@tr.find_all_by_merchant_id(12334615)).to eq([])
    end
  end

  describe '#update' do
    it 'updates the values of the item at id with attributes passed in' do
      @tr.update(263395237,{ name: 'Turkey Leg', unit_price: 100})
      expect(@transaction1.name).to eq('Turkey Leg')
      expect(@transaction1.unit_price_to_dollars).to eq(100)
    end
  end

  describe '#delete' do
    it 'deletes the item at the specified id index' do
      @tr.delete(263395237)
      expect(@tr.all).to eq([@transaction2, @transaction3, @transaction4, @transaction5])
    end
  end
end
