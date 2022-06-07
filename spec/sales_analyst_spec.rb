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
    array = @analyst.merchants_with_high_item_count
    expect(array).to be_a Array
    if array.count > 0
      expect(array[0]).to be_a Merchant
    end
  end

  it "can give us the average item price for a merchant" do
    expect(@items.find_all_by_merchant_id('12334105').count).to eq 3
    expect(@analyst.average_item_price_for_merchant('12334105')).to be_a BigDecimal
  end

  it 'can give us the average average item price for a merchant' do
    expect(@analyst.average_average_price_per_merchant).to be_a BigDecimal
  end

  it 'can return an array of golden items' do
    array = @analyst.golden_items
    expect(array).to be_a Array
    if array.count > 0
      expect(array[0]).to be_a Item
    end
  end
end
