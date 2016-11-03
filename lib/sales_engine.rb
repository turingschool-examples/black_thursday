require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'

class SalesEngine

  def self.from_csv(data)
    @invoices = InvoiceRepository.new(data[:invoices], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @items = ItemRepository.new(data[:items], self)
    self
  end

  def self.items
    @items
  end

  def self.merchants
    @merchants
  end

  def self.invoices
    @invoices
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