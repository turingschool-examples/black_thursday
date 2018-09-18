require_relative 'merchant_repository'
require_relative 'item_repository'
require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices

  def initialize(csv_hash)
    @merchants = MerchantRepository.new(csv_hash[:merchants])
    @items     = ItemRepository.new(csv_hash[:items])
    @invoices  = InvoiceRepository.new(csv_hash[:invoices])
  end

  def self.from_csv(csv_hash)
   new(csv_hash)
  end

  def analyst
     SalesAnalyst.new(self)
  end

end
