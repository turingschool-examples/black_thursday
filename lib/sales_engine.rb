require 'csv'
require 'pry'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './merchant'
require_relative './item'
require_relative './sales_analyst'
require_relative './invoice_item_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst,
              :invoice_items

  def initialize(sales_data)
    @items = ItemRepository.new(sales_data[:items], self)
    @merchants = MerchantRepository.new(sales_data[:merchants], self)
    @analyst = SalesAnalyst.new(self)
    @invoice_items = InvoiceItemRepository.new(sales_data[:invoice_items], self)
  end

  def self.from_csv(sales_data)
    SalesEngine.new(sales_data)
  end
end
