require './lib/sales_engine'
require './lib/merchant_repository'
# require 'simplecov'
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
      expect(merch_rep.find_by_id("500000")).to eq(nil)
      expect(merch_rep.find_by_id("12334105").name).to eq("Shopin1901")
    end

    it 'can find by name' do
      expect(merch_rep.find_by_name("Candisart").id).to eq("12334112")
      expect(merch_rep.find_by_name("candISart").id).to eq("12334112")
    end

    it 'find all by name' do
      expect(merch_rep.find_all_by_name("Giovani")).to eq([])
      expect(merch_rep.find_all_by_name("Candi").count).to eq(1)
    end

    # it 'creates new merchants' do
    #   merchant = MerchantRepository.create({ :id => 5, :name => "Turing School" })
    #   expect(merchant).to be_instance_of(Merchant)
    #   # expect(merch_rep.create("WandaPetSupply")).to eq(Merchant.new("WandaPetSupply"))
    # end

    it 'makes a new id number' do
      new_number = (merch_rep.merchants.last.id.to_i)+1
      expect(merch_rep.new_id_number).to eq(new_number)
    end
  end
end
