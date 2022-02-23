require 'rspec'
require './lib/merchants_repository'

describe MerchantsRepository do
  describe '#initialize' do
    it 'exists' do
      mr = MerchantsRepository.new("./data/merchants.csv")
      expect(mr).to be_an_instance_of(MerchantsRepository)
    end
  end

  describe '#all' do
    it 'lists all merchants' do
      mr = MerchantsRepository.new("./data/merchants.csv")
      expect(mr.all).to eq(mr.repository)
    end
  end

  describe '#find_by_id' do
    it 'can find a merchant by the id' do
      mr = MerchantsRepository.new("./data/merchants.csv")
      merchant = mr.find_by_id("12336395")
      expect(merchant.id).to eq("12336395")
      expect(merchant.name).to eq("ACWBanners")
    end
  end

  describe '#find_by_name' do
    it 'can find a merchant by the name' do
      mr = MerchantsRepository.new("./data/merchants.csv")
      merchant = mr.find_by_name("cardsbymarykate")
      expect(merchant.name).to eq("cardsbymarykate")
      expect(merchant.id).to eq("12337409")
    end
  end

  describe '#find_all_by_name' do
    it 'can find all merchants that include the searched name and is case insensitve' do
      mr = MerchantsRepository.new("./data/merchants.csv")
      merchant = mr.find_all_by_name("Chris")
      expect(merchant.count).to eq(2)
      merchant = mr.find_all_by_name("CHRIS")
      expect(merchant.count).to eq(2)
      merchant = mr.find_all_by_name("sxyw")
      expect(merchant).to eq([])
    end
  end

  describe '#create' do
    it 'can create a new instance of Merchant class' do
      mr = MerchantsRepository.new("./data/merchants.csv")
      johnny = mr.create("Johnny")
      expect(johnny.class).to be(Merchant)
      merchant = mr.repository.sort_by do |merchant|
                  merchant.id
                end.last
      expect(merchant.id < johnny.id).to be true
      expect(johnny.name).to eq("Johnny")
    end
  end

end
