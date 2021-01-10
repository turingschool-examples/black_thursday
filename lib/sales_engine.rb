require 'csv'
require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices

  def initialize(locations)
    @merchants = MerchantRepository.new(locations[:merchants])
    @items = ItemRepository.new(locations[:items])
    @invoices = InvoiceRepository.new(locations[:invoices], self)
  end

  def self.from_csv(locations)
    SalesEngine.new(locations)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def total_invoices
    invoices.all.length
  end

  def per_merchant_invoice_count_hash
    invoices.per_merchant_invoice_count
  end
end
