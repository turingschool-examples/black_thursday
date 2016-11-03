require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'

class SalesEngine

  attr_accessor :items, :merchants

  def self.from_csv(data)
    @items_file = data[:items]
    @merchants_file = data[:merchants]
    @invoices_file = data[:invoices]
    self
  end

  def self.items
    ItemRepository.new(@items_file, self)
  end

  def self.merchants
    MerchantRepository.new(@merchants_file, self)
  end

  def self.invoices
    InvoiceRepository.new(@invoices_file, self)
  end

  def self.find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def self.find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def self.find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

end