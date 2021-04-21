require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/sales_analyst'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/item'
require './lib/merchant'

RSpec.describe SalesAnalyst do
  describe '#initialize' do
    it 'exists' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
      sales_analyst = se.analyst

      expect(sales_analyst).to be_a(SalesAnalyst)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'can find the average average item per merchant' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              })
      sales_analyst = se.analyst

      expect(sales_analyst.average_average_price_per_merchant).to eq(350.29)
    end
  end

  describe '#average_items_per_merchant' do
    it 'can find the average item per merchant' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
      sales_analyst = se.analyst

      expect(sales_analyst.average_items_per_merchant).to eq(1.0)
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'can find the average item per merchant standard deviation' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
      sales_analyst = se.analyst

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(0.82)
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'averages the item price for merchant' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
      sales_analyst = se.analyst

      expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(14)
    end
  end

  describe '#average_invoices_per_merchant' do
    it 'shows average number of invoices by merchant' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              })
      sales_analyst = se.analyst

      expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
    end
  end

  describe '#average_invoices_per_merchant_standard_deviation' do
    it 'shows standard deviation of invoices by merchant' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              })
      sales_analyst = se.analyst

      expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
    end
  end

  describe '#best_item_for_merchant' do
    it 'tells you the highest grossing item for a given merchant' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              })
      sales_analyst = se.analyst

      expect(sales_analyst.best_item_for_merchant(12334113)).to be_a(Item)
    end
  end

  describe '#bottom_merchants_by_invoice_count' do
    it 'tells which merchants are more than two std devs below the mean' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                              })
      sales_analyst = se.analyst
      expect(sales_analyst.bottom_merchants_by_invoice_count.count).to eq(4)
      expect(sales_analyst.bottom_merchants_by_invoice_count.first).to be_a(Merchant)
    end
  end

  describe '#golden_items' do
    it 'finds items greater than 2 std dev above average item price' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
      sales_analyst = se.analyst

      expect(sales_analyst.golden_items).to eq([])
    end
  end

  describe '#invoice_paid_in_full?' do
    it 'tells you if an invoice has been paid in full' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
        sales_analyst = se.analyst

      expect(sales_analyst.invoice_paid_in_full?(1)).to eq(true)
    end
  end

  describe '#invoice_status' do
    it 'returns the status invoice by percentage' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
        sales_analyst = se.analyst

        expect(sales_analyst.invoice_status('pending')).to eq(50.0)
    end
  end

  describe '#invoice_total' do
    it 'tells you the total price of an invoice' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
        sales_analyst = se.analyst

      expect(sales_analyst.invoice_total(1)).to eq(21067.77)
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'can find which merchants sell the most items' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
      sales_analyst = se.analyst

      expect(sales_analyst.merchants_with_high_item_count[0].name).to eq("Shopin1901")
    end
  end

  describe '#merchants_with_only_one_item' do
    it 'returns merchants with only one item for sale' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
        sales_analyst = se.analyst

      expect(sales_analyst.merchants_with_only_one_item.count).to eq(2)
      expect(sales_analyst.merchants_with_only_one_item.last).to be_a(Merchant)
    end
  end

  describe '#merchants_with_only_one_item_registered_in_month' do
    it 'returns merchants with only one item for sale in a given month' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
        sales_analyst = se.analyst

      expect(sales_analyst.merchants_with_only_one_item_registered_in_month("March").count).to eq(1)
    end
  end

  describe '#merchants_with_pending_invoices' do
    it 'returns merchants with pending invoices' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
        sales_analyst = se.analyst

      expect(sales_analyst.merchants_with_pending_invoices.count).to eq(3)
      expect(sales_analyst.merchants_with_pending_invoices.last).to be_a(Merchant)
    end
  end

  describe '#most_sold_item' do
    it 'returns item(s) of which the merchant sold the highest qty' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                                })
        sales_analyst = se.analyst

        expect(sales_analyst.most_sold_item(12334113)[0]).to be_a(Item)
    end
  end

  describe '#revenue_by_merchant' do
    it 'returns total revenue for a given merchant' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
        sales_analyst = se.analyst
      expect(sales_analyst.revenue_by_merchant(1)).to eq(nil)
      expect(sales_analyst.revenue_by_merchant(12334113)).to eq(0)
    end
  end

  describe '#top_days_by_invoice_count' do
    it 'returns the top sales days' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
        sales_analyst = se.analyst

      expect(sales_analyst.top_days_by_invoice_count).to eq(['Friday', 'Saturday'])
    end
  end

  describe '#top_merchants_by_invoice_count' do
    it 'tells which merchants are more than two std devs above the mean' do
      se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv'
                                })
        sales_analyst = se.analyst

      expect(sales_analyst.top_merchants_by_invoice_count.count).to eq(12)
      expect(sales_analyst.top_merchants_by_invoice_count.first).to be_a(Merchant)
    end
  end

  describe '#top_revenue_earners' do
    it 'returns the specified number of top-earning merchants' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
      sales_analyst = se.analyst
      expect(sales_analyst.top_revenue_earners(5).count).to eq(5)
    end
  end

  describe '#total_revenue_by_date' do
    it 'tells you the total revenue on a specific date' do
      se = SalesEngine.from_csv({
        items: './spec/truncated_data/items_truncated.csv',
        merchants: './spec/truncated_data/merchants_truncated.csv',
        invoices: './spec/truncated_data/invoices_truncated.csv',
        customers: './spec/truncated_data/customers_truncated.csv',
        invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
        transactions: './spec/truncated_data/transactions_truncated.csv'
                              })
        sales_analyst = se.analyst

      expect(sales_analyst.total_revenue_by_date(Time.parse("2009-02-07"))).to eq(21067.77)
    end
  end
end
