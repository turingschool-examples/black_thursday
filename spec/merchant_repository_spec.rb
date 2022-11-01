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

      m1 = Merchant.new({:id => 12334105, :name => Shopin1901})
      m2 = Merchant.new({:id => 12334112, :name => Candisart})
      m3 = Merchant.new({:id => 12334113, :name => MiniatureBikez})
      m4 = Merchant.new({:id => 12334115, :name => LolaMarleys})

      expect(mr.merchants).to eq([m1, m2, m3, m4])
    end
  end
end