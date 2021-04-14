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
      expect(mr.find_all_by_name("corgi")).to eq([])
    end

    it 'can create a new merchant instance' do
      attributes = {
        name: "Turing School of Software and Design"
      }
      mr.create(attributes)
      expected = mr.find_by_id(12337412)
      expect(expected.name).to eq "Turing School of Software and Design"
    end

    it 'can update a merchant' do
      # update the Merchant instance with the corresponding id with the provided attributes.
      # Only the merchant’s name attribute can be updated.
      attributes = {
        name: "TSSD"
      }

      mr.update(12337412, attributes)

      expected = mr.find_by_id(12337412)
      expect(expected.name).to eq "TSSD"

      expected = mr.find_by_name("Turing School of Software and Design")
      expect(expected).to eq nil
    end

    it 'can delete a specific merchant' do
      mr.delete(12337412)
      expected = mr.find_by_id(12337412)
      expect(expected).to eq nil
    end
  end
end
