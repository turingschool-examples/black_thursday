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
  :invoices => "./data/invoices.csv"
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
      merchant_1 = mr.find_by_id(12334281)
      merchant_2 = mr.find_by_id(12334904)
      merchant_3 = mr.find_by_id(12337211)
      expect(mr.find_all_by_name("style").length).to eq 3
      expect(mr.find_all_by_name("style")).to eq([merchant_1, merchant_2, merchant_3])
      expect(mr.find_all_by_name("corgi")).to eq([])
    end

    it 'can create a new merchant instance' do
      attributes = {
        name: "Regina is cool"
      }
      mr.create(attributes)
      expected = mr.find_by_id(12337412)
      expect(expected.name).to eq("Regina is cool")
    end

    it 'can update a merchant' do
      attributes = {
        name: "NewStore67"
      }

      mr.update(12337412, attributes)

      expected = mr.find_by_id(12337412)
      expect(expected.name).to eq("NewStore67")

      expected = mr.find_by_name("Regina is cool")
      expect(expected).to eq(nil)
    end

    it 'can delete a specific merchant' do
      mr.delete(12337412)
      expected = mr.find_by_id(12337412)
      expect(expected).to eq(nil)
    end
  end
end
