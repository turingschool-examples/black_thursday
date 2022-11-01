require 'rspec'
require './lib/merchant_repository'

describe MerchantRepository do
  describe '#initialize' do
    let(:mr) { MerchantRepository.new }

    it 'is and instance of MerchantRepository' do
      expect(mr).to be_a MerchantRepository
    end

    it 'can store an array of merchants' do
      expect(mr.merchants).to eq([])
    end
  end

  describe '#create' do
    xit 'creates a Merchant and adds it to @merchants' do

      expect(mr.merchants).to eq([])
    end
  end
end