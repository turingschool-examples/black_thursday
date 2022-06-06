require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoices,
              :analyst

  def initialize(items_path, merchants_path, invoice_path)
    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new(merchants_path)
    @invoices = InvoiceRepository.new(invoice_path)
    @analyst = SalesAnalyst.new(@item_repository, @merchant_repository)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices])
  end

end
