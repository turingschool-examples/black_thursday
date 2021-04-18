require 'csv'
require_relative 'sales_analyst'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :customers,
              :invoice_items,
              :invoices,
              :items,
              :merchants,
              :transactions,
              :analyst

  def initialize(item_csv_location,
                 merchant_csv_location,
                 invoice_csv_location,
                 customer_csv_location)
    @customers = CustomerRepository.new(customer_csv_location, self)
    # @invoice_items = './data/invoice_items.csv'
    @invoices = InvoiceRepository.new(invoice_csv_location, self)
    @items = ItemRepository.new(item_csv_location, self)
    @merchants = MerchantRepository.new(merchant_csv_location, self)
    # @transactions = './data/transactions.csv'
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(csv_hash)
    item_csv_location = csv_hash[:items]
    merchant_csv_location = csv_hash[:merchants]
    invoice_csv_location = csv_hash[:invoices]
    customer_csv_location = csv_hash[:customers]
    SalesEngine.new(item_csv_location,
                    merchant_csv_location,
                    invoice_csv_location,
                    customer_csv_location)
  end

  def all_items
    @items.all
  end

  def invoice_percentage_by_status(status)
    @invoices.percentage_by_status(status)
  end

  def find_merchant_by_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_item_by_id(item_id)
    @items.find_by_id(item_id)
  end

  def average_invoices_per_merchant
    @invoices.average_invoices_per_merchant
  end

  def stdev_invoices_per_merchant
    @invoices.stdev_invoices_per_merchant
  end

  def top_merchants_by_invoice_count
    @invoices.top_merchants_by_invoice_count
  end

  def bottom_merchants_by_invoice_count
    @invoices.bottom_merchants_by_invoice_count
  end

  def top_days_by_invoice_count
    @invoices.top_sales_days
  end

  def average_items_per_merchant
    @items.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    @items.average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    @items.merchants_with_high_item_count
  end

  def average_item_price_for_merchant(merchant_id)
    @items.average_item_price_for_merchant(merchant_id)
  end

  def average_average_price_per_merchant
    @items.average_average_price_per_merchant
  end

  def golden_items
    @items.golden_items
  end
end
