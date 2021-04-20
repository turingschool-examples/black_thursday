require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/items'
require './lib/merchants'
require './items_repo'
require './merchants_repo'
require './invoices'
require './invoices_repo'
require 'rspec'

RSpec.describe SalesAnalyst do

  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices  => "./data/invoices.csv",
  :invoice_items => "./data/invoice_items.csv",
  :transactions => "./data/transactions.csv",
  :customers => "./data/customers.csv"
  })
  sales_analyst = se.analyst

  context 'Instanstiation' do
    it 'exists' do
      expect(sales_analyst).to be_instance_of(SalesAnalyst)
    end
  end

  context 'methods' do
    xit 'can return average items per merchant' do
      expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    end

    xit 'can return standard deviation of items per merchant' do
      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end

    xit "can return merchants with the most items" do
      expected = sales_analyst.merchants_with_high_item_count

      expect(expected.length).to eq(52)
      expect(expected.first.class).to eq(Merchant)
      expect(expected.class).to eq(Array)
    end

    xit 'can find the average price of a merchants items' do

      expect(sales_analyst.average_item_price_for_merchant(12334105).class).to eq(BigDecimal)
      expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(0.1666e2)
    end

    xit 'can find the average of average price' do
      expect(sales_analyst.average_average_price_per_merchant.class).to eq(BigDecimal)
      expect(sales_analyst.average_average_price_per_merchant).to eq(0.35029e3)
    end

    xit 'can return items 2 standard deviations above average item price' do
      expect(sales_analyst.golden_items.class).to eq(Array)
      expect(sales_analyst.golden_items.length).to eq(5)
    end

    xit 'can return average invoices per merchant' do
      expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
    end

    xit 'can return average invoice per merchant with standard deviation' do
      expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    end

    xit 'can return which merchants are two standard deviations above the average' do
      expect(sales_analyst.top_merchants_by_invoice_count.class).to eq(Array)
      expect(sales_analyst.top_merchants_by_invoice_count.length).to eq(12)
      expect(sales_analyst.top_merchants_by_invoice_count.first.class).to eq(Merchant)
    end

    xit 'can return which merchants are two standard deviations below the average' do
      expect(sales_analyst.bottom_merchants_by_invoice_count.class).to eq(Array)
      expect(sales_analyst.bottom_merchants_by_invoice_count.length).to eq(4)
      expect(sales_analyst.bottom_merchants_by_invoice_count.first.class).to eq(Merchant)
    end

    xit 'can return top days by invoice count' do
      expect(sales_analyst.top_days_by_invoice_count).to eq(["Wednesday"])
    end

    xit 'can return percentage of invoices matching a status' do
      expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
      expect(sales_analyst.invoice_status(:shipped)).to eq(56.95)
      expect(sales_analyst.invoice_status(:returned)).to eq(13.5)
    end

    it 'can see if paid in full ' do
      expect(sales_analyst.invoice_paid_in_full?(2179)).to eq(true)
      expect(sales_analyst.invoice_paid_in_full?(1752)).to eq(false)
    end

    it 'can get the total of the invoice' do
      expect(sales_analyst.invoice_total(46)).to eq(BigDecimal(98668)/100)
      expect(sales_analyst.invoice_total(46).class).to eq(BigDecimal)
    end
  end
end
