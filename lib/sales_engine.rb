require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'invoice_repository'
require 'csv'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(args)
    @items = ItemRepository.new(args[:items], self)
    @merchants = MerchantRepository.new(args[:merchants], self)
    @invoices = InvoiceRepository.new(args[:invoices], self)
  end

  def self.from_csv(args)
    new(args)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end


# item_path = "./data/items.csv"
# merchant_path = "./data/merchants.csv"
# arguments = {
#               :items     => item_path,
#               :merchants => merchant_path,
#             }
# se = SalesEngine.new(arguments)
# require "pry"; binding.pry
