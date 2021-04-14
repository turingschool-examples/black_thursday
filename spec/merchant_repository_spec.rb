require 'CSV'
require 'RSpec'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repository'
# require './data/merchants.csv'

RSpec.describe MerchantRepo do
  describe 'instantiation' do
    it '::new' do
      merchant_repo = MerchantRepo.new

    expect(merchant_repo).to be_an_instance_of(MerchantRepo)
    end
  end

  describe '#methods' do
    it '#populates information' do
      merchant_repo = MerchantRepo.new

      expect(merchant_repo.populate_information).to be_an_instance_of(Hash)
    end

    it '#all' do
      merchant_repo = MerchantRepo.new

      # expect(merchant_repo.all.length).to eq(475)
      expect(merchant_repo.all).to eq([])
    end

    #is this necessary - yes, add nil assertion above
    # it '#returns nil by default' do
    #   merchant_repo = MerchantRepo.new
    #   expect(merchant_repo.find_by_id(5)).to eq(nil)
    # end

    it '#find Merchant by ID' do
      merchant_repo = MerchantRepo.new
      merchant_repo.populate_information
      merchant_repo.all

      #consider alternative assertion
      expect(merchant_repo.find_by_id("12334105").name).to eq("Shopin1901")
    end
  end
end
