require_relative 'spec_helper'
require_relative '../lib/merchant_repository'

RSpec.describe MerchantRepository do
  before :each do
    @repo = MerchantRepository.new('./spec/fixtures/mock_merchants.csv')
  end

    it 'exists' do
      expect(@repo).to be_an_instance_of(MerchantRepository)
    end

    it 'returns all merchants' do
      expect(@repo.all.length).to eq(3)
    end

    it 'creates real items from csv' do
      @repo.all.each do |merchant|
        expect(merchant).to be_an_instance_of(Merchant)
      end
    end

    it 'can find a merchant by id' do
      expect(@repo.find_by_id(101).name).to eq("KoopShop")
      expect(@repo.find_by_id(1)).to eq(nil)
      expect(@repo.find_by_id(103).name).to eq("SparkyShop")
    end

    it 'can find a merchant by name' do
      expect(@repo.find_by_name("KoopShop").id).to eq(101)
      expect(@repo.find_by_name("AlfieHouse")).to eq(nil)
      expect(@repo.find_by_name("SparkyShop").id).to eq(103)
    end

    it 'can find all matches to the name fragment' do
      shop_ids = []
      @repo.find_all_by_name("shop").each do |shop|
        shop_ids << shop.id
      end
      expect(shop_ids).to eq([101, 103])

      @repo.find_all_by_name("Alfie").each do |shop|
        expect(shop.id).to eq([])
      end
    end

    it 'creates the next highest merchant id' do
      expect(@repo.next_highest_merchant_id).to eq(104)
    end

    it 'can create a new merchant instance' do
      attributes = {name: "AlfieHouse"}

      @repo.create(attributes)

      updated_all = []
      @repo.all.each do |merchant|
        updated_all << merchant.name
      end

      updated_all_id = []
      @repo.all.each do |merchant|
        updated_all_id << merchant.id
      end

      expect(updated_all).to eq(["KoopShop", "CookieCounter", "SparkyShop", "AlfieHouse"])

      expect(updated_all_id).to eq([101, 102, 103, 104])
    end

    it 'can update an exsisting merchants name' do
      attributes_1 = {name: "NolaHouse"}

      @repo.update(101, attributes_1)

      expect(@repo.find_by_id(101).name).to eq("NolaHouse")

      attributes_2 = {id: 200}
      @repo.update(101, attributes_2)

      expect(@repo.find_by_id(200)).to eq(nil)
    end

    it 'can delete the merchant by id' do
      @repo.delete(101)

      updated_all = []
      @repo.all.each do |merchant|
        updated_all << merchant.name
      end
        expect(updated_all).to eq(["CookieCounter", "SparkyShop"])
    end

end
