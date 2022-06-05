require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :merchants, :items, :invoices

  def initialize(items_filepath, merchants_filepath, invoices_filepath)
    @items = ItemRepository.new(items_filepath)
    @merchants = MerchantRepository.new(merchants_filepath)
    @invoices = InvoiceRepository.new(invoices_filepath)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices])
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices)
  end
end
