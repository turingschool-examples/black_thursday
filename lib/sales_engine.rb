require 'csv'
require_relative 'sales_analyst'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :customers,
              :invoice_items,
              :invoices,
              :items,
              :merchants,
              :transactions,
              :analyst

  def initialize(item_csv_location, merchant_csv_location, invoice_csv_location)
    # @customers = './data/customers.csv'
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
    SalesEngine.new(item_csv_location, merchant_csv_location, invoice_csv_location)
  end

  def all_items
    @items.all
  end
end
