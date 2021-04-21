require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'
require './lib/invoice_repository'
require './lib/transaction_repository'

RSpec.describe SalesEngine do
  before do
    # @se = SalesEngine.from_csv({
    #   items: './spec/truncated_data/items_truncated.csv',
    #   merchants: './spec/truncated_data/merchants_truncated.csv',
    #   invoices: './spec/truncated_data/invoices_truncated.csv',
    #   customers: './spec/truncated_data/customers_truncated.csv',
    #   invoice_items: './spec/truncated_data/invoice_items_truncated.csv',
    #   transactions: './spec/truncated_data/transactions_truncated.csv'
    #                         })
    @se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      customers: './spec/truncated_data/customers_truncated.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
                            })
  end

  describe '#initialize' do
    it 'exists' do
      expect(@se).to be_instance_of(SalesEngine)
    end

    it 'creates an ItemRepository' do
      expect(@se.items).to be_instance_of(ItemRepository)
    end

    it 'creates an InvoiceRepository' do
      expect(@se.invoices).to be_instance_of(InvoiceRepository)
    end

    it 'creates an TransactionRepository' do
      expect(@se.transactions).to be_instance_of(TransactionRepository)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'shows average price across all merchants' do
      expect(@se.average_average_price_per_merchant).to eq(0.35029e3)
    end
  end

  describe '#average_invoices_per_merchant' do
    it 'shows average invoices per merchant' do
      expect(@se.average_invoices_per_merchant).to eq(10.49)
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'shows average item price for a given merchant' do
      expect(@se.average_item_price_for_merchant(12334113)).to eq(0.15e3)
    end
  end

  describe '#average_items_per_merchant' do
    it 'shows average items per merchant' do
      expect(@se.average_items_per_merchant).to eq(2.88)
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'shows standard deviation of average items per merchant' do
      expect(@se.average_items_per_merchant_standard_deviation).to eq(3.26)
    end
  end

  describe '#best_item_for_merchant' do
    it 'shows best item for a merchant' do
      @se = SalesEngine.from_csv({
                                   items: './data/items.csv',
                                   merchants: './data/merchants.csv',
                                   invoices: './data/invoices.csv',
                                   customers: './data/customers.csv',
                                   invoice_items: './data/invoice_items.csv',
                                   transactions: './data/transactions.csv'
                                 })
      expect(@se.best_item_for_merchant(12334113).id).to eq(263422571)
    end
  end

  describe '#bottom_merchants_by_invoice_count' do
    it 'shows bottom merchants by invoice count' do
      expect(@se.bottom_merchants_by_invoice_count.count).to eq(4)
    end
  end

  describe '#find_customer_by_id' do
    it 'returns a customer_object when given a customer_id' do
      expect(@se.find_customer_by_id(1)).to be_a(Customer)
    end
  end

  describe '#find_invoice_by_id' do
    it 'finds and invoice by invoice_id' do
      expect(@se.find_invoice_by_id(1)).to be_a(Invoice)
    end
  end

  describe '#find_item_by_id' do
    it 'returns a item_object when given a item_id' do
      expect(@se.find_item_by_id(263395618)).to be_a(Item)
    end
  end

  describe '#find_merchant_by_id' do
    it 'returns a merchant_object when given a merchant_id' do
      expect(@se.find_merchant_by_id(12334105)).to be_a(Merchant)
    end
  end

  describe '#golden_items' do
    it 'shows golden items which are 2 std dev above average item price' do
      expect(@se.golden_items.count).to eq(5)
    end
  end

  describe '#invoice_paid_in_full?' do
    it 'tells you if an invoice has been paid in full' do
      expect(@se.invoice_paid_in_full?(1)).to eq(true)
    end
  end

  describe '#invoice_status' do
    it 'shows percent of invoices by status' do
      expect(@se.invoice_status(:pending)).to eq(29.55)
      expect(@se.invoice_status(:shipped)).to eq(56.95)
      expect(@se.invoice_status(:returned)).to eq(13.5)
    end
  end

  describe '#invoice_total_hash' do
    it 'passes the invoice_total_hash from invoice_item repo to other repos' do
      expect(@se.invoice_total_hash.keys.count).to eq(2810)
    end
  end
  describe '#invoice_total_value' do
    it 'returns the total value of an invoice' do
      expect(@se.invoice_total_value(1)).to eq(21067.77)
    end
  end

  describe '#invoice_paid_in_full?' do
    it 'shows if an invoice is paid in full' do
      expect(@se.invoice_paid_in_full?(1)).to eq(true)
    end
  end

  describe '#items_created_in_month' do
    it 'returns invoices created in a specified month' do
      expect(@se.items_created_in_month("March").count).to eq(475)
    end
  end

  describe '#merchant_invoice_items' do
    it 'returns items by invoice id' do
      expect(@se.merchant_invoice_items(12335938).count).to eq(0)
    end
  end

  describe '#merchant_sold_item_quantity_hash' do
    it 'returns hash of sold items' do
      expect(@se.merchant_sold_item_quantity_hash(12334105).count).to eq(28)
    end
  end

  describe '#merchant_sold_item_revenue_hash' do
    it 'returns hash of sold items' do
      expect(@se.merchant_sold_item_quantity_hash(12334105).count).to eq(28)
    end
  end

  describe '#merchant_items' do
    it 'returns hash of merchant items' do
      expect(@se.merchant_items(12334105).count).to eq(3)
    end
  end

  describe '#merchant_invoices' do
    it 'returns merchant invoices by merchant id' do
      expect(@se.merchant_invoices(12334105).count).to eq(10)
    end
  end

  describe '#merchants_with_only_one_item' do
    it 'returns merchants with only one item' do
      expect(@se.merchants_with_only_one_item.count).to eq(243)
    end
  end

  describe '#merchants_with_only_one_item_registered_in_month' do
    it 'returns merchants with only one item in a specified month' do
      expect(@se.merchants_with_only_one_item_registered_in_month("March").count).to eq(21)
    end
  end

  describe '#merchants_with_pending_invoices' do
    it 'returns merchants with pending invoices' do
      expect(@se.merchants_with_pending_invoices.count).to eq(467)
    end
  end

  describe '#most_sold_item' do
    it 'returns most sold item by merchant id' do
      expect(@se.most_sold_item(12334105).count).to eq(0)
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns merchants with high item counts' do
      expect(@se.merchants_with_high_item_count.count).to eq(52)
    end
  end

  describe '#merchant_successful_invoice_array' do
    it 'returns array of successful invoices by merchant id' do
      expect(@se.merchant_successful_invoice_array(12334105).count).to eq(5)
    end
  end

  describe '#revenue_by_merchant' do
    it 'returns total revenue for a specified merchant' do
      expect(@se.revenue_by_merchant(12333333)).to eq(nil)
    end
  end

  describe '#stdev_invoices_per_merchant' do
    it 'returns the standard deviation of invoices per merchant' do
      expect(@se.stdev_invoices_per_merchant).to eq(3.29)
    end
  end

  describe '#top_days_by_invoice_count' do
    it 'shows top days by invoice count' do
      expect(@se.top_days_by_invoice_count).to eq(['Wednesday'])
    end
  end

  describe '#top_merchants_by_invoice_count' do
    it 'shows top merchants by invoice count' do
      expect(@se.top_merchants_by_invoice_count.count).to eq(12)
    end
  end

  describe '#top_revenue_earners' do
    it 'returns the specified number of top-earning merchants' do
      expect(@se.top_revenue_earners(2).count).to eq(2)
    end
  end

  describe '#total_revenue_by_date' do
    it 'returns the total revenue on a specified date' do
      expect(@se.total_revenue_by_date(Time.parse("2009-02-07"))).to eq(21067.77)
    end
  end

  describe '#total_revenue_by_merchant' do
    it 'returns array of merchant id\'s and total revenue' do
      expect(@se.total_revenue_by_merchant.count).to eq(950)
    end
  end

  describe '#total_revenue_by_merchant_by_month' do
    it 'returns the total revenue for a specified merchant by month' do
      expect(@se.total_revenue_by_merchant_by_month('March')).to eq({})
    end
  end

  describe '#top_revenue_earners' do
    it 'returns array of merchant id\'s and total revenue' do
      expect(@se.top_revenue_earners(2).count).to eq(2)
    end
  end
end
