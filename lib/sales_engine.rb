require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'sales_analysis'

class SalesEngine
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def items
    @items ||= ItemRepository.new(path[:items], self)
  end

  def merchants
    @merchants ||= MerchantRepository.new(path[:merchants], self)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(path[:invoices], self)
  end

  def self.from_csv(path)
    new(path)
  end

  def analyst
    @analyst ||= SalesAnalyst.new(self)
  end

  def collect_invoices_by_merchant_id(id)
    invoices.find_all_by_merchant_id(id)
  end

  def collect_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end
end

#memoization
#This operator only sets the variable if the variable is false or Nil.
