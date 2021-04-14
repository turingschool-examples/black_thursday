require 'rspec'
require './lib/sales_engine'
require './lib/items'
require './lib/items_repo'
require './lib/merchants'
require './lib/merchants_repo'

RSpec.describe MerchantRepo do

  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })
  mr = se.merchants

  context 'it exists' do
    it 'exists' do
      expect(mr).to be_instance_of(MerchantRepo)
    end
  end

  context 'methods' do
    it 'has attributes' do
      expect(mr.merchants_list[0]).to be_instance_of(Merchant)
      expect(mr.merchants_list.length).to eq(475)
    end

    it 'can find all instances of merchant' do
      expect(mr.all.length).to eq(475)
    end

    it 'can find by id' do
      expect(mr.find_by_id(12334105)).to be_instance_of(Merchant)
      expect(mr.find_by_id(12334105)).to eq(mr.merchants_list[0])
    end

    it 'can find by name' do
      expect(mr.find_by_name("Shopin1901")).to be_instance_of(Merchant)
      expect(mr.find_by_name("Shopin1901")).to eq(mr.merchants_list[0])
      expect(mr.find_by_name("shopin1901")).to eq(mr.merchants_list[0])
    end

    it 'can find all by name' do
      fragment = "style"
      expected = mr.find_all_by_name(fragment)

      expect(expected.length).to eq 3
      expect(expected.map(&:name).include?("justMstyle")).to eq true
      expect(expected.map(&:id).include?(12337211)).to eq true
    end
  end

end
