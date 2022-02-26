require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'CSV'
require 'simplecov'
SimpleCov.start

RSpec.describe SalesAnalyst do

  before(:each) do
    @sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices => "./data/invoices.csv"
          })
    @sales_analyst = @sales_engine.analyst
  end

  describe '#Iteration 1: creates a working sales analyst' do

    it 'exists' do
      expect(@sales_analyst).to be_a(SalesAnalyst)
    end

    it 'can calculate average items per merchant' do
      expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
    end

    it 'can calculate average items per merchant standard deviation' do
      expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end

    it 'dispays merchants with high item count' do
      expect(@sales_analyst.merchants_with_high_item_count[0]).to be_a(Merchant)
      expect(@sales_analyst.merchants_with_high_item_count.count).to eq(52)
    end

    it 'finds average item price per merchant' do
      expect(@sales_analyst.average_item_price_for_merchant(12334159)).to be_a(BigDecimal)
      expect(@sales_analyst.average_item_price_for_merchant(12334105).to_f).to eq(16.66)
    end

    it 'finds average price across all merchants' do
      expect(@sales_analyst.average_average_price_per_merchant).to be_a(BigDecimal)
      expect(@sales_analyst.average_average_price_per_merchant).to eq(350.29)
    end

    it 'finds items two STD above average price' do
      expect(@sales_analyst.golden_items.length).to eq(5)
      expect(@sales_analyst.golden_items.first.class).to eq(Item)
    end
  end

  describe "#Iteration 2: creates business intelligence" do

    it 'can determine the average invoices per merchant' do
      expect(@sales_analyst.average_invoices_per_merchant).to eq(10.49)
    end

    it "can determine the average invoices per merchant's STD" do
      expect(@sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    end

    it "can determine the top performing merchants" do
      expect(@sales_analyst.top_merchants_by_invoice_count.count).to eq(12)
      expect(@sales_analyst.top_merchants_by_invoice_count[0]).to be_a(Merchant)
    end

    it "can determine the lowest performing merchants" do
      expect(@sales_analyst.bottom_merchants_by_invoice_count.count).to eq(4)
      expect(@sales_analyst.bottom_merchants_by_invoice_count[0]).to be_a(Merchant)
    end

    it "can determine the day of the keep based on an invoice" do
      expect(@sales_analyst.invoices_per_day).to be_a(Hash)
      expect(@sales_analyst.invoices_per_day.keys.count).to eq(7)
    end

    it "can determine average invoices by day" do
      expect(@sales_analyst.average_invoices_per_day).to eq(712)
    end

    it "can determine invoices by day" do
      expect(@sales_analyst.invoices_by_day.count).to eq(4985)
    end

    it "can determine invoices by day STD" do
      expect(@sales_analyst.invoices_per_day_STD.round).to eq(18)
    end

    it "can determine the days with the most sales" do
      expect(@sales_analyst.top_days_by_invoice_count).to eq(["Wednesday"])
    end

    it "can determine the percentage of invoices based on status" do
      expect(@sales_analyst.invoice_status(:pending)).to eq(29.55)
      expect(@sales_analyst.invoice_status(:shipped)).to eq(56.95)
      expect(@sales_analyst.invoice_status(:returned)).to eq(13.5)
    end

  end

end
