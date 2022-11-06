require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/sales_analyst'

RSpec.describe SalesAnalyst do
  let(:sales_engine) do
    SalesEngine.from_csv({
                           items: './data/items.csv',
                           merchants: './data/merchants.csv',
                           invoices: './data/invoices.csv'
                         })
   end

  it 'exists' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_instance_of(SalesAnalyst)
  end

  it 'checks average items per merchant' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'checks average items per merchant standard deviation' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'returns merchants with high item counts' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.merchants_with_high_item_count).to be_a(Array)
    expect(sales_analyst.merchants_with_high_item_count[0]).to be_a(Merchant)
  end

  it 'checks average item price for merchant)' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_item_price_for_merchant(12_334_159)).to be_a(BigDecimal)
  end

  it '#average average price per merchant' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_average_price_per_merchant).to be_a(BigDecimal)
  end

  it '#golden items' do
  sales_analyst = sales_engine.analyst
  expect(sales_analyst.golden_items).to be_a(Array)
  expect(sales_analyst.golden_items[0]).to be_a(Item)
  end

  it '#average_invoices_per_merchant' do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  it "#average_invoices_per_merchant_standard_deviation" do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  it "#uniq_merchant_ids" do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.uniq_merchant_ids).to be_instance_of(Array)
  end

  it "#merchants_with_invoices" do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.merchants_with_invoices).to be_instance_of(Array)
  end

  xit "#top_merchants_by_invoice_count" do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.top_merchants_by_invoice_count).to be_instance_of(Array)
    expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
  end

  it "#bottom_merchants_by_invoice_count" do
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.bottom_merchants_by_invoice_count).to be_instance_of(Array)
    expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
  end
end
