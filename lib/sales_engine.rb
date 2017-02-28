require 'csv'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require 'pry'

class SalesEngine
  attr_reader :item_csv, :merchant_csv

  def self.from_csv(csv_hash)
    @item_csv = csv_hash[:items]
    @merchant_csv = csv_hash[:merchants]
    @invoice_csv = csv_hash[:invoices]
    return self
  end

  def self.items
    ItemRepository.new(@item_csv, self)
  end

  def self.merchants
    MerchantRepository.new(@merchant_csv, self)
  end

  def self.invoices
    InvoiceRepository.new(@invoice_csv, self)
  end

end


