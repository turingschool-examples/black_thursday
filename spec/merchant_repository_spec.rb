require_relative '../lib/merchant_repository'
require 'simplecov'
SimpleCov.start

RSpec.describe MerchantRepository do

  before(:each) do
    @merchant_repo = MerchantRepository.new('./data/mini_merchants.csv')
  end

  describe '#initialize' do
    it 'is initialized with a data file' do

      expect(@merchant_repo.filename).to eq('./data/mini_merchants.csv')
    end
  end

  describe '#all' do
    it 'can create a merchant instance for every line on the data file' do

      expect(@merchant_repo.all.count).to eq(19)
    end
  end

  describe '#find_by_id' do
    it 'can create merchant instances for each id passed as an argument' do

      expect(@merchant_repo.find_by_id("12334105").count).to eq(1)

      expect(@merchant_repo.find_by_id("00000000")).to eq(nil)
    end
  end
end
