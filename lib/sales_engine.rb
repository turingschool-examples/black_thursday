require 'csv'
require 'pry'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './merchant'
require_relative './item'
require_relative './invoice_repository'
require_relative './invoice'
require_relative './sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :analyst
              

  def initialize(sales_data)
    @items = ItemRepository.new(sales_data[:items], self)
    @merchants = MerchantRepository.new(sales_data[:merchants], self)
    @invoices = InvoiceRepository.new(sales_data[:invoices], self)
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(sales_data)
    SalesEngine.new(sales_data)
  end
end
