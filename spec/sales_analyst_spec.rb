require "CSV"
require "RSpec"
require "./lib/sales_engine"
require "./lib/item"
require "./lib/item_repo"
require "./lib/merchant_repo"
require "./lib/sales_analyst"

RSpec.describe SalesAnalyst do
  before(:each) do
    @sales_engine = SalesEngine.from_csv({:items => './data/items.csv',
                                          :merchants => './data/merchants.csv',
                                          :invoices => './data/invoices.csv',
                                          :invoice_items => './data/invoice_items.csv',
                                          :transactions  => './data/transactions.csv',
                                          :customers => './data/customers.csv'
                                        })
  end

  describe 'instantiation' do
    it '::new' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    end
  end

  describe 'methods' do

    xit '#total items' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.item_count).to eq(1367.0)
    end

    xit '#total merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.merchant_count).to eq(475.0)
    end

    xit '#average items per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    end

    xit '#average items price' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_price.class).to eq(Float)
    end

    xit '#item count per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.item_count_per_merchant.class).to eq(Hash)
    end

    xit '#standard deviation items per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end

    xit '#standard deviation items price' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_item_price_standard_deviation).to eq(2899.93)
    end

    xit '#merchant with highest item count' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.merchants_with_high_item_count.first.class).to eq(Merchant)
    end

    xit '#average item price for merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(16.66)
    end

    xit '#average average price per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_average_price_per_merchant).to eq(350.29)
    end

    xit '#golden items' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.golden_items.length).to eq 5
      expect(sales_analyst.golden_items.first.class).to eq Item
    end

    xit '#invoice count' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.invoice_count).to eq(4985.0)
    end

    xit '#average invoices per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
    end

    xit '#invoice count' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.invoice_count).to eq(4985.0)
    end

    xit '#average invoices per merchant standard deviation' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    end

    xit '#invoice count per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.invoice_count_per_merchant.class).to eq(Hash)
    end

    xit '#top merchants by invoice count' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
    end

    xit '#bottom merchants by invoice count' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
    end

    xit '#top days by invoice count' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.top_days_by_invoice_count.length).to eq 1
      expect(sales_analyst.top_days_by_invoice_count.first).to eq "Wednesday"
      expect(sales_analyst.top_days_by_invoice_count.first.class).to eq String
    end

    xit '#invoice_status' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.invoice_status(:pending)).to eq 29.55
      expect(sales_analyst.invoice_status(:shipped)).to eq 56.95
      expect(sales_analyst.invoice_status(:returned)).to eq 13.5
    end

    it '#invoice paid in full?' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.invoice_paid_in_full?(1)).to eq(true)
      expect(sales_analyst.invoice_paid_in_full?(203)).to eq(false)
    end

    it '#invoice_total' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.invoice_total(1)).to eq(21067.77)
      expect(expecte.invoice_total(1).class).to eq(BigDecimal)
    end
  end
end
