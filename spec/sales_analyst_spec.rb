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
    xit '::new' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    end
  end

  describe 'methods' do

    xit '#average items per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    end

    xit '#standard deviation items per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end

    xit '#average_item_price_standard_deviation' do
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

    it '#average average price per merchant' do
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

    it '#average invoices per merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
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

    xit '#average_invoice_per_day_standard_deviation' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.average_invoice_per_day_standard_deviation).to eq(18.07)
    end

    xit '#top days by invoice count' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.top_days_by_invoice_count.length).to eq 1
      expect(sales_analyst.top_days_by_invoice_count.first).to eq "Wednesday"
      expect(sales_analyst.top_days_by_invoice_count.first.class).to eq String
    end

    xit '#invoice status' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.invoice_status(:pending)).to eq 29.55
      expect(sales_analyst.invoice_status(:shipped)).to eq 56.95
      expect(sales_analyst.invoice_status(:returned)).to eq 13.5
    end

    xit '#invoice paid in full?' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.invoice_paid_in_full?(200)).to eq(true)
      expect(sales_analyst.invoice_paid_in_full?(203)).to eq(false)
    end

    xit '#invoice total' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.invoice_total(1)).to eq(21067.77)
    end

    xit '#total revenue by date' do
      sales_analyst = @sales_engine.analyst
      date = Time.parse("2009-02-07")

      expect(sales_analyst.total_revenue_by_date(date)).to eq(21067.77)
    end

    xit '#revenue by merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.revenue_by_merchant_id).to be_a(Hash)
    end

    xit '#top revenue earners' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.top_revenue_earners.first).to be_a(Merchant)
      expect(sales_analyst.top_revenue_earners(10).length).to eq(10)
    end

    xit '#ranked by revenue' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.merchants_ranked_by_revenue.first).to be_a(Merchant)
      expect(sales_analyst.merchants_ranked_by_revenue.first.id).to eq(12334634)
    end

    xit '#merchants with pending invoices' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.merchants_with_pending_invoices.length).to eq(467)
    end

    xit '#merchants with only one item' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.merchants_with_only_one_item.length).to eq(243)
    end

    xit '#merchants with only one item registered in month' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.merchants_with_only_one_item_registered_in_month("March").length).to eq(21)
    end

    xit '#revenue by merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.revenue_by_merchant(12334194)).to be_a(BigDecimal)
    end

    #blog items

    xit '#most sold item for merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.most_sold_item_for_merchant(merchant_id)).to be_an(Array)
    end

    xit '#best item for merchant' do
      sales_analyst = @sales_engine.analyst

      expect(sales_analyst.best_item_for_merchant(merchant_id)).to be_an(Item)
    end
  end
end
