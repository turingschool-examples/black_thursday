require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :path,
              :items,
              :merchants,
              :invoices

  def initialize(path)
    @items ||= ItemRepository.new(path[:items], self)
    @merchants ||= MerchantRepository.new(path[:merchants], self)
    @invoices ||= InvoiceRepository.new(path[:invoices], self)

  end

  def self.from_csv(path)
    SalesEngine.new(path)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
