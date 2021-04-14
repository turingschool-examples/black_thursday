require 'CSV'
require 'RSpec'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repository'
# require './data/merchants.csv'

RSpec.describe MerchantRepo do
  describe 'instantiation' do
    it '::new' do
      mr = MerchantRepo.new

    expect(mr).to be_an_instance_of(MerchantRepo)
    end
  end

  describe '#methods' do
    it '#populates information' do
      mr = MerchantRepo.new

      expect(mr.populate_information).to be_an_instance_of(Hash)
    end

    it '#all' do
      mr = MerchantRepo.new

      mr.add_merchants
      expect(mr.all.length).to eq(475)
    end

    #is this necessary
    # it '#returns nil by default' do
    #   mr = MerchantRepo.new
    #   expect(mr.find_by_id(5)).to eq(nil)
    # end

    it '#returns a Merchant with matching ID' do
      mr = MerchantRepo.new
      mr.populate_information
      mr.add_merchants

      #consider alternative assertion
      expect(mr.find_by_id("12334105").name).to eq("Shopin1901")
    end

  end
end
