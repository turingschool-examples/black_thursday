require_relative 'file_loader'
require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
class SalesEngine
    attr_reader :merchants, :items, :invoices, :sales_analyst

  def initialize(path_1, path_2, path_3)
    @merchants = MerchantRepository.new(path_2)
    @items = ItemRepository.new(path_1)
    @invoices = InvoiceRepository.new(path_3)
  end

  def self.from_csv(data)
    self.new(data[:items], data[:merchants], data[:invoices])
  end

  def analyst
    @sales_analyst = SalesAnalyst.new(self)
  end
end
