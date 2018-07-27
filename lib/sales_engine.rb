require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'invoice_repository'
require_relative 'invoice'
require_relative 'invoice_item_repository'
require_relative 'invoice_item'
require_relative 'sales_analyst'

class SalesEngine
  def self.from_csv(file_hash)
    items = []
    CSV.foreach(file_hash[:items], headers: true, header_converters: :symbol) do |row|
      items << Item.new(row)
    end
    merchants = []
    CSV.foreach(file_hash[:merchants], headers: true, header_converters: :symbol) do |row|
      merchants << Merchant.new(row)
    end
    invoices = []
    CSV.foreach(file_hash[:invoices], headers: true, header_converters: :symbol) do |row|
      invoices << Invoice.new(row)
    end
    invoice_items = []
    CSV.foreach(file_hash[:invoice_items], headers: true, header_converters: :symbol) do |row|
      invoice_items << InvoiceItem.new(row)
    end
    SalesEngine.new(items, merchants, invoices, invoice_items)
  end

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items

  def initialize(items, merchants, invoices, invoice_items)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
    @invoices = InvoiceRepository.new(invoices)
    @invoice_items = InvoiceItemRepository.new(invoice_items)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items)
  end
end
