require_relative '../lib/sales_engine'


RSpec.describe SalesEngine do
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
                                        })
    xit 'exists' do
      expect(sales_engine).to be_instance_of(SalesEngine)
    end

    xit 'makes a hash' do
      expect(sales_engine.merchants).to eq("./data/merchants.csv")
    end

    it 'parse csv' do
      expect(SalesEngine.parse_csv("./data/merchants.csv")).to be_instance_of(Array)
      expect(SalesEngine.parse_csv("./data/items.csv")).to be_instance_of(Array)
    end

    it 'creates hashes' do
      expect(SalesEngine.parse_csv("./data/merchants.csv")[0]).to be_instance_of(Hash)
    end
  end
end
