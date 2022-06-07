require 'pry'
require_relative "merchant_repository"
require_relative "item_repository"
require_relative "sales_analyst"
require_relative "invoice_repository"
require_relative "invoice_item_repository"

class SalesEngine
  attr_reader :item_repository, :merchant_repository, :invoices, :analyst, :invoice_items

  def initialize(file_paths)

    @item_repository = ItemRepository.new(file_paths[:items])
    @merchant_repository = MerchantRepository.new(file_paths[:merchants])
    @invoices = InvoiceRepository.new(file_paths[:invoices])
    @analyst = SalesAnalyst.new(@item_repository, @merchant_repository)
    @invoice_items = InvoiceItemRepository.new(file_paths[:invoice_items])
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end
end
