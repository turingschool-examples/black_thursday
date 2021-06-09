
require 'csv'
require 'math_module'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require_relative 'customer'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :merchants, :items, :analyst, :invoices, :customers

  def initialize(paths)
    @items = ItemRepository.new(paths[:items], self)
    @merchants = MerchantRepository.new(paths[:merchants], self)
    @invoices = InvoiceRepository.new(paths[:invoices], self)
    @customers = CustomerRepository.new(paths[:customers], self)
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(paths)
    SalesEngine.new(paths)
  end
end
