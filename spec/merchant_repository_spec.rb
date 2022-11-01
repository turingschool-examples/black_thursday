require 'rspec'
require 'csv'
require './lib/merchant_repository'

describe MerchantRepository do
  let(:mr) { MerchantRepository.new }
  let(:data) { CSV.open './data/merchants_test.csv', headers: true, header_converters: :symbol }

  describe '#initialize' do

    it 'is and instance of MerchantRepository' do
      expect(mr).to be_a MerchantRepository
    end

    it 'can store an array of merchants' do
      expect(mr.merchants).to eq([])
    end
  end

  describe '#create' do
    it 'creates a Merchant and adds it to @merchants' do
      data.each { |line| mr.create(line) }
      
      expect(mr.merchants[0].id).to eq("12334105")
      expect(mr.merchants[1].id).to eq("12334112")
      expect(mr.merchants[2].id).to eq("12334113")
      expect(mr.merchants[3].id).to eq("12334115")
      expect(mr.merchants[0].name).to eq("Shopin1901")
      expect(mr.merchants[1].name).to eq("Candisart")
      expect(mr.merchants[2].name).to eq("MiniatureBikez")
      expect(mr.merchants[3].name).to eq("LolaMarleys")
    end
  end
end