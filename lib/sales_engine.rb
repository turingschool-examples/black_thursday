require 'bigdecimal'
require 'csv'
require 'time'
require_relative 'fileio'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'repository'
require_relative 'sales_analyst'
# Sales Engine class for managing data
class SalesEngine
  attr_reader :invoices,
              :items,
              :merchants

  def initialize(invoice_repo, item_repo, merchant_repo)
    @invoices = invoice_repo
    @items = item_repo
    @merchants = merchant_repo
  end

  def self.from_csv(items_merchants_invoices)
    invoices_file_path = FileIO.load(items_merchants_invoices[:invoices])
    invoices_repo = InvoiceRepository.new(invoices_file_path)
    items_file_path = FileIO.load(items_merchants_invoices[:items])
    items_repo = ItemRepository.new(items_file_path)
    merchants_file_path = FileIO.load(items_merchants_invoices[:merchants])
    merchants_repo = MerchantRepository.new(merchants_file_path)
    new(invoices_repo, items_repo, merchants_repo)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
