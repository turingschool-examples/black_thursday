require_relative '../lib/sales_engine'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

RSpec.describe MerchantRepository do

  # Parameter (array of hashes) should be passed
  # into new instance
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
                                        })
    merch_rep = sales_engine.merchants

    it 'exists' do
      expect(merch_rep).to be_instance_of(MerchantRepository)
    end

    it 'can access merchants' do
      expect(merch_rep.merchants[0]).to be_instance_of(Merchant)
    end

    it 'can create merchant objects' do
      merchant_data = SalesEngine.parse_csv("./data/merchants.csv")
      expect(merch_rep.create_merchants(merchant_data)[0]).to be_instance_of(Merchant)
    end
  end

  describe 'database functionality' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
                                        })
    merch_rep = sales_engine.merchants

    it 'returns array of all merchants' do
      merchant_count = merch_rep.merchants.count
      expect(merch_rep.all.count).to eq(merchant_count)
    end

    it 'can find by id' do
      expect(merch_rep.find_by_id(500000)).to eq(nil)
      expect(merch_rep.find_by_id(12334105).name).to eq("Shopin1901")
    end

    it 'can find by name' do
      expect(merch_rep.find_by_name("Candisart").id).to eq(12334112)
      expect(merch_rep.find_by_name("candISart").id).to eq(12334112)
    end

    it 'find all by name' do
      expect(merch_rep.find_all_by_name("Giovani")).to eq([])
      expect(merch_rep.find_all_by_name("Candi").count).to eq(1)
    end

    it 'creates new merchants' do
      expect(merch_rep.create({ :id => 5, :name => "Turing School" }).last).to be_instance_of(Merchant)
    end

    it 'makes a new id number' do
      new_number = (merch_rep.merchants.last.id)+1
      expect(merch_rep.new_id_number).to eq(new_number)
    end

    it 'can update existing merchant' do
      # attributes = { :id => 5, :name => "Turing School" }
      # merch_rep.update(12334112, attributes)
      # targeted_merchant = merch_rep.find_by_id(12334112)
      # expect(targeted_merchant.name).to eq("Turing School")
      attributes = {
      name: "TSSD"
      }
      merch_rep.update(12337412, attributes)
      expected = merch_rep.find_by_id(12337412)
      expect(expected.name).to eq "TSSD"
      expected = merch_rep.find_by_name("Turing School of Software and Design")
    expect(expected).to eq nil
    end

    it 'can delete merchant' do
      merch_rep.delete(12334112)
      targeted_merchant = merch_rep.find_by_id(12334112)
      expect(targeted_merchant).to eq(nil)
    end
  end
end
