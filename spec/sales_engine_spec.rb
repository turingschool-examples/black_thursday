require './spec_helper'
require './lib/sales_engine'

RSpec.describe SalesEngine do
  describe '#initialize' do
    it 'exists' do
      se = se = SalesEngine.new({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})

      expect(se).to be_a(SalesEngine)
    end
  end

  describe '#items' do
    it 'creates and returns an item repository object' do
      se = se = SalesEngine.new({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})
      ir = se.items

      expect(ir).to be_a(ItemRepository)
    end

    it 'contains the data from the csv file' do
      se = se = SalesEngine.new({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})
      ir = se.items

      expect(ir.find_by_id("263395237")).to be_a(Item)
      expect(ir.find_by_id("263395237").name).to eq("510+ RealPush Icon Set")
      expect(ir.find_by_name("HOT Crystal Dragon Fly Hand Blown Glass Art Gold Trim Figurine Lucky Collection")).to be_a(Item)
    end
  end

  describe '#merchants' do
    it 'creates and returns a merchant repository object' do
      se = se = SalesEngine.new({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})
      mr = se.merchants

      expect(mr).to be_a(MerchantRepository)
    end

    it 'contains the data from the csv file' do
      se = se = SalesEngine.new({
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'})
      mr = se.merchants

      expect(mr.find_by_id("12334105")).to be_a(Merchant)
      expect(mr.find_by_id("12334105").name).to eq("Shopin1901")
      expect(mr.find_by_name("SassyStrangeArt")).to be_a(Merchant)
    end
  end
end
