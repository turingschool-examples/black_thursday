require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

RSpec.describe SalesAnalyst do
  it '#exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'can return the average num of items per merchant' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    # require 'pry'; binding.pry
    sales_analyst = se.analyst
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'can return the average num of items per merchant standard deviation' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    # require 'pry'; binding.pry
    sales_analyst = se.analyst
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'can return merchants with a high item count' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    # require 'pry'; binding.pry
    sales_analyst = se.analyst
    merchants_with_high_item_count_id = sales_analyst.merchants_with_high_item_count.map do |merchant|
      merchant.id
    end
    expect(merchants_with_high_item_count_id.include?(12334195)).to eq (true)
    expect(merchants_with_high_item_count_id.include?(12334105)).to eq (false)
  end 
end
