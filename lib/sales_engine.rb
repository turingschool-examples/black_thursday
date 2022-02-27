require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'sales_analyst'
require 'pry'

class SalesEngine
  attr_accessor :items, :merchants, :hash, :invoices, :invoice_items
  def initialize(items, merchants, invoices, invoice_items)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @invoice_items = invoice_items
  end

  def self.from_csv(info)
    @items = ItemRepository.new(info[:items])
    @merchants = MerchantRepository.new(info[:merchants])
    @invoices = InvoiceRepository.new(info[:invoices])
    @invoice_items = InvoiceItemRepository.new(info[:invoice_items])
    new(@items, @merchants, @invoices, @invoice_items)
  end

  def analyst
    SalesAnalyst.new(@merchants, @items, @invoices)
  end


end
