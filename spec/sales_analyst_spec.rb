require_relative 'spec_helper'

RSpec.describe 'SalesAnalyst' do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      })
    @sales_analyst = @sales_engine.analyst
  end
  describe 'instantiation' do
    xit 'exists' do
      expect(@sales_analyst).to be_a(SalesAnalyst)
    end

    xit 'has access to Sales Engine' do
      expect(@sales_engine.merchants).to be_a(MerchantRepository)
      expect(@sales_engine.all_merchants).to be_an(Array)
    end
  end

  describe 'methods' do
    xit 'can return the average items per merchant' do
      expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
    end

    xit 'can return number of items per merchant' do
      expect(@sales_analyst.number_items_per_merchant).to be_an(Hash)
    end

    xit 'can return an average' do
      data = [1, 5, 9]

      expect(@sales_analyst.avg(data)).to eq(5)
    end

    xit 'can deviate in a standard way' do
      data = [21, 4224, 17, 8008]
      expect(@sales_analyst.std_dev(data)).to eq(3844.16)
    end

    xit 'can return the average items per mechant standard dev' do
      expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end

    xit 'can return the merchants that have the most items for sale' do
      expect(@sales_analyst.merchants_with_high_item_count).to be_an(Array)
      expect(@sales_analyst.merchants_with_high_item_count.count).to eq(52)
    end

    xit 'can find the average price of a merchants items' do
      merchant_id = 12334159

      expect(@sales_analyst.average_item_price_for_merchant(merchant_id)).to be_a(BigDecimal)
    end

    xit 'can sum all the averages and find the average price across all merchants' do
      expect(@sales_analyst.average_average_price_per_merchant).to be_a(BigDecimal)
    end

    xit 'can find items that are two deviations above the average price' do
      expect(@sales_analyst.golden_items).to be_an(Array)
      expect(@sales_analyst.golden_items.first).to be_an(Item)
      expect(@sales_analyst.golden_items.length).to eq(5)
    end

    xit 'can return number of invoices the average merchant has' do
      expect(@sales_analyst.average_invoices_per_merchant).to eq(10.49)
    end

    xit 'can return standard deviation of average invoices per merchant' do
      expect(@sales_analyst.average_invoices_per_merchant_standard_deviation). to eq(3.29)
    end

    xit 'can return merchants that are more than 2 standard deviations above the mean' do
      expect(@sales_analyst.top_merchants_by_invoice_count).to be_an(Array)
      expect(@sales_analyst.top_merchants_by_invoice_count.first).to be_a(Merchant)
      expect(@sales_analyst.top_merchants_by_invoice_count.count).to eq(12)
    end

    xit 'can find the merchants more than 2 standard deviations below the mean' do
      expect(@sales_analyst.bottom_merchants_by_invoice_count).to be_an(Array)
      expect(@sales_analyst.bottom_merchants_by_invoice_count.first).to be_a(Merchant)
    end

    
  end
end
