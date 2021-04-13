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
      m = Merchant.new({:id => 5, :name => "Turing School"})

      expect(mr.populate_information).to be_an_instance_of(Hash)
    end
  end
end
