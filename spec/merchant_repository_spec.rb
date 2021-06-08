require_relative 'spec_helper'
require_relative '../lib/merchant_repository'

RSpec.describe MerchantRepository do
  before :each do
    @repo = MerchantRepository.new('./spec/fixtures/mock_merchants.csv')
  end

    it 'exists' do
      expect(@repo).to be_an_instance_of(MerchantRepository)
    end

    it 'can create new merchant instances' do
      expect(@repo.all.length).to eq(50)

      @repo.all.each do |merchant|
        expect(merchant).to be_an_instance_of(Merchant)
      end
    end

    it 'can find a merchant by id' do
      expect(@repo.find_by_id(12334146).name).to eq("MotankiDarena")
      expect(@repo.find_by_id(1)).to eq(nil)
      expect(@repo.find_by_id(12334277).name).to eq("tmsDOM")
    end

    it 'can find a merchant by name' do
      expect(@repo.find_by_name("MotankiDarena").id).to eq(12334146)
      expect(@repo.find_by_name("AlfieHouse")).to eq(nil)
      expect(@repo.find_by_name("tmsDOM").id).to eq(12334277)
    end

    it 'can find all matches to the name fragment' do
      shop_ids = []
      @repo.find_all_by_name("shop").each do |shop|
        shop_ids << shop.id
      end
      expect(shop_ids).to eq([11111, 12334176, 12334257, 12334299])

      @repo.find_all_by_name("Alfie").each do |shop|
        expect(shop.id).to eq([])
      end
    end

    it 'creates the next highest merchant id' do
      expect(@repo.next_highest_merchant_id).to eq(12334300)
    end

    it 'can create a new merchant instance' do
      attributes = {name: "AlfieHouse"}

      @repo.create(attributes)

      expect(@repo.all.length).to eq(51)
      expect(@repo.find_by_id(12334202).name).to eq("VectorCoast")
    end

    it 'can update an exsisting merchants name' do
      attributes_1 = {name: "NolaHouse"}

      @repo.update(12334280, attributes_1)

      expect(@repo.find_by_id(12334280).name).to eq("NolaHouse")

      attributes_2 = {id: 200}
      @repo.update(101, attributes_2)

      expect(@repo.find_by_id(200)).to eq(nil)
    end

    it 'can delete the merchant by id' do
      @repo.delete(12334280)

      expect(@repo.all.length).to eq(49)
      expect(@repo.find_by_id(12334280)).to eq(nil)
    end

    it 'can connect merchant instances to their id' do
      expect(@repo.merchant_instance_by_id[11111]).to eq(@repo.find_by_id(11111))
    end
end
