require_relative '../lib/sales_engine'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

RSpec.describe MerchantRepository do

  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                                          :items     => "./data/items.csv",
                                          :merchants => "./data/merchants.csv",
                                          :invoices => "./data/invoices.csv",
                                          :customers => "./data/customers.csv",
                                          :invoice_items => "./data/invoice_items.csv",
                                          :transactions => "./data/transactions.csv"
                                          })
    merch_rep = sales_engine.merchants

    it 'exists' do
      expect(merch_rep).to be_instance_of(MerchantRepository)
    end

    it 'can access merchants' do
      expect(merch_rep.array_of_objects[0]).to be_instance_of(Merchant)
    end

    it 'can create merchant objects' do
      expect(merch_rep.array_of_objects[0]).to be_instance_of(Merchant)
    end
  end

  describe 'database functionality' do
    sales_engine = SalesEngine.from_csv({
                                          :items     => "./data/items.csv",
                                          :merchants => "./data/merchants.csv",
                                          :invoices => "./data/invoices.csv",
                                          :customers => "./data/customers.csv",
                                          :invoice_items => "./data/invoice_items.csv",
                                          :transactions => "./data/transactions.csv"
                                          })
    merch_rep = sales_engine.merchants

#REPEATED IN REPOSITORY TESTS
    it '#all returns array of all merchants' do
      merchant_count = merch_rep.array_of_objects.count
      expect(merch_rep.all.count).to eq(merchant_count)
    end

#REPEATED IN REPOSITORY TESTS
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
      attributes = {:name => "Turing School of Software and Design"}
      expected = "Turing School of Software and Design"

      merch_rep.create(attributes, Merchant)

      expect(merch_rep.all.last.name).to eq(expected)
    end

    it 'can update existing merchant' do
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
