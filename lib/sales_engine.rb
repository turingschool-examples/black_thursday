require 'csv'
require './lib/items_repository'
require './lib/merchants_repository'

class SalesEngine

  def initialize(info)
    @items = info[:items]
    @merchants = info[:merchants]
    @invoice_items = info[:invoice_items]
    @invoices = info[:invoices]
  end

  def self.from_csv(info)
    SalesEngine.new(info)
  end

  def items
    ItemsRepository.new(@items)
  end

  def merchants
    MerchantsRepository.new(@merchants)
  end

  def invoice_items_repo
    InvoiceItemsRepository.new(@invoice_items)
  end

end #SalesEngine class end
