require 'pry'
require_relative "merchant_repository"
require_relative "item_repository"
require_relative "sales_analyst"
require_relative "invoice_repository"

class SalesEngine
  attr_reader :items, :merchants, :invoices, :analyst

  def initialize(items, merchants, invoices)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
    @invoices = InvoiceRepository.new(invoices)
    @analyst = SalesAnalyst.new(@items, @merchants)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices])
  end

end
