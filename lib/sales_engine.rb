require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/invoice_repository'
require './lib/item'
require './lib/merchant'
require './lib/invoice'
require 'csv'
require 'pry'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :analyst

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    @invoices = InvoiceRepository.new(data[:invoices])
    @analyst = SalesAnalyst.new({
                                 :items => @items,
                                 :merchants => @merchants,
                                 :invoices => @invoices
                                 })
  end

end
