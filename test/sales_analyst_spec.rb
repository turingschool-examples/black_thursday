require_relative './spec_helper'

RSpec.describe SalesAnalyst do
  before :each do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
       :merchants => "./data/merchants.csv",
       :invoice => "./data/invoices.csv",
       :invoice_items => "./data/invoice_items.csv"
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
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26) #change to 3.26 if population sd
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

  it 'can find the average price of a merchants items' do
    expect(@sales_analyst.average_item_price_for_merchant(12334105)).to eq(16.66)
    expect(@sales_analyst.average_item_price_for_merchant(12334105).class).to eq(Float)
  end

  it 'find the average price across all merchants' do
    expect(@sales_analyst.average_average_price_per_merchant).to eq(350.29)
    expect(@sales_analyst.average_average_price_per_merchant.class).to eq(Float)
  end

  it 'finds the Golden Items that are two standard deviations above the average item price' do
    expect(@sales_analyst.golden_items.length).to eq(5)
    expect(@sales_analyst.golden_items.first.class).to eq(Item)
  end

  it 'finds the average invoices per merchant' do
    expect(@sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  it 'can tell you the standard deviation of average invoices per merchant' do
    expect(@sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  it 'finds the top merchants by invoice count' do
    expect(@sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
  end

  it 'finds the bottom merchants by invoice count' do
    expect(@sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
  end

  # it 'finds the top days of the week by invoice count' do
  #   expect(@sales_analyst.top_days_by_invoice_count.legth).to eq(1)
  # end

  it 'returns the invoice status percentage of if invoices with given status' do
    expect(@sales_analyst.invoice_status(:pending)).to eq(29.55)
    expect(@sales_analyst.invoice_status(:shipped)).to eq(56.95)
    expect(@sales_analyst.invoice_status(:returned)).to eq(13.5)
  end

end
