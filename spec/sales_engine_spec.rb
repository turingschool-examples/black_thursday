require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'
require './lib/invoice_repository'
require './lib/transaction_repository'

RSpec.describe SalesEngine do
  before do
    @se = SalesEngine.from_csv({
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        customers: './data/customers.csv',
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

  describe '#invoice_percentage_by_status' do
    it 'shows percent of invoices by status' do

      expect(@se.invoice_percentage_by_status(:pending)).to eq(29.55)
      expect(@se.invoice_percentage_by_status(:shipped)).to eq(56.95)
      expect(@se.invoice_percentage_by_status(:returned)).to eq(13.5)
    end
  end

  describe '#find_merchant_by_id' do
    it 'returns a merchant_object when given a merchant_id' do

      expect(@se.find_merchant_by_id(12334105)).to be_a(Merchant)
    end
  end

  describe '#find_item_by_id' do
    it 'returns a item_object when given a item_id' do

      expect(@se.find_item_by_id(263404585)).to be_a(Item)
    end
  end

  describe '#average_invoices_per_merchant' do
    it 'shows average invoices per merchant' do

      expect(@se.average_invoices_per_merchant).to eq(10.49)
    end
  end

  describe '#stdev_invoices_per_merchant' do
    it 'shows standard deviation of invoices per merchant' do

      expect(@se.stdev_invoices_per_merchant).to eq(3.29)
    end
  end

  describe '#top_merchants_by_invoice_count' do
    it 'shows top merchants by invoice count' do

      expect(@se.top_merchants_by_invoice_count.count).to eq(12)
      expect(@se.top_merchants_by_invoice_count.first).to be_a(Merchant)
    end
  end

  describe '#bottom_merchants_by_invoice_count' do
    it 'shows bottom merchants by invoice count' do

      expect(@se.bottom_merchants_by_invoice_count.count).to eq(4)
      expect(@se.bottom_merchants_by_invoice_count.first).to be_a(Merchant)
    end
  end

  describe '#top_days_by_invoice_count' do
    it 'shows top days by invoice count' do

      expect(@se.top_days_by_invoice_count).to eq(['Wednesday'])
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

  describe '#merchants_with_high_item_count' do
    it 'shows merchants with high item count' do

      expect(@se.merchants_with_high_item_count.count).to eq(52)
      expect(@se.merchants_with_high_item_count.first).to be_a(Merchant)
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'shows average item price for a given merchant' do

      expect(@se.average_item_price_for_merchant(12334123)).to eq(0.1e3)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'shows average price across all merchants' do

      expect(@se.average_average_price_per_merchant).to eq(0.35029e3)
    end
  end

  describe '#golden_items' do
    it 'shows golden items which are 2 std dev above average item price' do

      expect(@se.golden_items.count).to eq(5)
      expect(@se.golden_items.first).to be_a(Item)
    end
  end

  describe '#invoice_total_hash' do
    it 'passes the invoice_total_hash from invoice_item repo to other repos' do

      expect(@se.invoice_total_hash.keys.count).to eq(4985)
    end
  end
end
