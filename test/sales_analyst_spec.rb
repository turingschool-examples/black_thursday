require_relative './spec_helper'

RSpec.describe SalesAnalyst do
  before :each do
    sales_engine = SalesEngine.from_csv({
     :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    @sales_analyst = sales_engine.analyst
  end

  it 'is a SalesAnalyst' do
    expect(@sales_analyst).to be_instance_of(SalesAnalyst)
  end

  it 'can tell you the average items per merchant' do
    expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'can tell you the standard deviation of average items per merchant' do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to be_instance_of(Float) #change to 3.26 if population sd
  end

  it 'can find Merchant ids to be used to calculate standard deviation' do
    expect(@sales_analyst.merchant_ids.class).to eq(Array)
    expect(@sales_analyst.merchant_ids[0]).to eq(12334105)
  end

  it 'can create a list of count of items sold per merchant'do
    @sales_analyst.merchant_ids
    expect(@sales_analyst.items_count_list.class).to eq(Array)
    expect(@sales_analyst.items_count_list[0]).to eq(3)
  end

  it 'can tell you which Merchants sell the most Items' do
      expect(@sales_analyst.merchants_with_high_item_count.length).to eq(52)
      expect(@sales_analyst.merchants_with_high_item_count.first.class).to eq Merchant
      expect(@sales_analyst.merchants_with_high_item_count.first.name).to eq("Keckenbauer")
  end
end
