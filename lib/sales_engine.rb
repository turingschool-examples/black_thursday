require 'csv'
require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'

class SalesEngine
  attr_reader :csv_hash,
              :items,
              :merchants,
              :invoices
  def initialize(csv_hash)# keys: items, merchants; values: paths to csv files
    @csv_hash = csv_hash
    @items = ItemRepository.new(csv_hash[:items])
    @items.create_items
    @merchants = MerchantRepository.new(csv_hash[:merchants])
    @merchants.create_all_from_csv(csv_hash[:merchants])
    @invoices = InvoiceRepository.new(csv_hash[:invoices])
    @invoices.create_invoices(csv_hash[:invoices])
  end

  def self.from_csv(csv_hash)
    SalesEngine.new(csv_hash)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
