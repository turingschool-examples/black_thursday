require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
 # require_relative 'sales_analyst'
class SalesEngine

  attr_reader :merchants, :items, :invoices

  def initialize(items_path, merchants_path, invoice_path)
    @items_path = items_path
    @merchants_path = merchants_path
    @invoice_path = invoice_path
    @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchants_path)
    @invoices = InvoiceRepository.new(invoice_path)
    # @analyst= SalesAnalyst.new(items_path, merchants_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices])
  end

  def analyst
    SalesAnalyst.new(@items_path,@merchants_path)
  end
end
