require_relative './merchant_repository'
require_relative './merchant'
require_relative './item_repository'
require_relative './item'
require_relative './invoice_repository'
require_relative './invoice'
require 'csv'
require 'bigdecimal'
require 'time'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices

  def initialize(merchants_filepath, items_filepath, invoices_filepath)
    @merchants = MerchantRepository.new(merchants_filepath)
    @items = ItemRepository.new(items_filepath)
    @invoices = InvoiceRepository.new(invoices_filepath)
  end

  def self.from_csv(filepath_hash)
    merchants_filepath = filepath_hash[:merchants]
    items_filepath = filepath_hash[:items]
    invoices_filepath = filepath_hash[:invoices]
    SalesEngine.new(merchants_filepath, items_filepath, invoices_filepath)
  end

  def analyst
  SalesAnalyst.new(@merchants, @items)
  end

end
