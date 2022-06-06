require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'
require 'pry'

describe SalesAnalyst do
  before(:each) do
    @merchants = MerchantRepository.new('./data/merchants.csv')
    @items = ItemRepository.new('./data/items.csv')
    @analyst = SalesAnalyst.new(@items, @merchants)
  end

  it "is an instance of SalesAnalyst" do
    expect(@analyst).to be_a(SalesAnalyst)
  end

  it "creates a hash with the correct amount of keys" do
    expect(@analyst.merchant_hash.keys.count).to eq(475)
  end


  it "can give us the average items per merchant" do
    expect(@analyst.average_items_per_merchant).to eq(2.88)
  end

  it "can give us the standard deviation of the items sold" do
    expect(@analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it "can give us all the merchants with a high item count" do
  end

  it "can give us the average item price for a merchant" do
    expect(@items.find_all_by_merchant_id('12334105').count).to eq 3
    expect(@analyst.average_item_price_for_merchant('12334105')).to be_a BigDecimal
    expect(@analyst.average_item_price_for_merchant('12334105')).to eq 0.4997e2
  end
end
