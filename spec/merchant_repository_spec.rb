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
end
