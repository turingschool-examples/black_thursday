require_relative './merchant_repository'
require_relative './merchant'
require_relative './item_repository'
require_relative './item'
require_relative './invoice_repository'
require_relative './invoice'
require_relative './invoice_item_repository'
require_relative './invoice_item'
require 'csv'
require 'bigdecimal'
require 'time'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items

  def initialize(merchants_filepath, items_filepath, invoices_filepath, invoice_items_filepath)
    @merchants = MerchantRepository.new(merchants_filepath)
    @items = ItemRepository.new(items_filepath)
    @invoices = InvoiceRepository.new(invoices_filepath)
    @invoice_items = InvoiceItemRepository.new(invoice_items_filepath)
  end

  def self.from_csv(filepath_hash)
    merchants_filepath = filepath_hash[:merchants]
    items_filepath = filepath_hash[:items]
    invoices_filepath = filepath_hash[:invoices]
    invoice_items_filepath = filepath_hash[:invoice_items]
    SalesEngine.new(merchants_filepath, items_filepath, invoices_filepath, invoice_items_filepath)
  end

  def analyst
    SalesAnalyst.new(@merchants, @items, @invoices, @invoice_items)
  end

end
