# sales_engine
require 'CSV'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'invoice'
require_relative 'sales_analyst'
require_relative 'invoice_items'
require_relative 'invoice_items_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items

  def initialize(items_, merchants_, invoices_, invoice_items_)
    @items = ItemRepository.new(items_)
    @merchants = MerchantRepository.new(merchants_)
    @invoices = InvoiceRepository.new(invoices_)
    @invoice_items = InvoiceItemsRepository.new(invoice_items_)
  end

  def self.from_csv(csv_hash)
    item_contents = CSV.open csv_hash[:items], headers: true, header_converters: :symbol
    merchant_contents = CSV.open csv_hash[:merchants], headers: true, header_converters: :symbol
    invoice_contents = CSV.open csv_hash[:invoices], headers: true, header_converters: :symbol
    invoice_items_contents = CSV.open csv_hash[:invoice_items], headers: true, header_converters: :symbol


    # read file, create objects, return SE object
    items = []
    item_contents.each do |row|
      items << Item.new(row)
    end

    merchants = []
    merchant_contents.each do |row|
      merchants << Merchant.new(row)
    end

    invoices = []
    invoice_contents.each do |row|
      invoices << Invoice.new(row)
    end

    invoice_items = []
    invoice_items_contents.each do |row|
      invoice_items << InvoiceItems.new(row)
    end

    se = SalesEngine.new(items, merchants, invoices, invoice_items)
    # assign_items_to_merchant
  end

  def analyst
    SalesAnalyst.new(@items.all, @merchants.all, @invoices.all, @invoice_items.all)
  end


end
