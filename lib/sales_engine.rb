require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require 'csv'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(path)
    @items = ItemRepository.new(path[:items])
    @merchants = MerchantRepository.new(path[:merchants])
    @invoices = InvoiceRepository.new(path[:invoices])
  end

  def self.from_csv(path)
    new(path)
  end

end
