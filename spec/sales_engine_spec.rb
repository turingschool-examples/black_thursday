require 'rspec'
require 'csv'
require './lib/sales_engine'
# require "./data/items.csv"
# require "./data/merchants.csv"

RSpec.describe SalesEngine do
  describe "from_csv" do
    
    
    it "exists" do
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",})
        expect(se).to be_a(SalesEngine)
    end 
    
    xit "item and merchants" do
      se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",})
      expect(se.items).to eq([:items])
      expect(se.merchants[:merchants]).to eq("./data/merchants.csv")
    end
    
    
    xit "takes CSVs and feeds them into attributes" do
      se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",})
    expect(se.merchants).to be_a(MerchantRepository)
    expect(se.items).to be_a(ItemRepository)
    expect(se.items).to_not eq([])  
    end
    
    
    
    
    
    
    
    
    
  end
end
