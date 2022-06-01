require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  before :each do
    @filepath = './data/merchants.csv'
    @collection = MerchantRepository.new(@filepath)
  end

  describe "#initialize" do
    it "is a MerchantRepository" do
      expect(@collection).to be_a MerchantRepository
    end

    it "can return an array of all known Merchant instances" do
      expect(@collection.all).to be_a Array
      expect(@collection.all.count).to eq 475
    end
  end

end
