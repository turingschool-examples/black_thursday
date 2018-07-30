
require 'csv'
require_relative './item'
require_relative './merchant'
require_relative './invoice'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './sales_analyst'

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
    @invoices.create_invoices

  end

  def self.from_csv(csv_hash)
    SalesEngine.new(csv_hash)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
