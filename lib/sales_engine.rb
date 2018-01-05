require "csv"
require_relative "merchant_repo"
require_relative "item_repo"

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices

  def self.from_csv(directory)
    SalesEngine.new(directory)
  end

  def initialize(directory)
    @merchants = MerchantRepo.new(self, directory[:merchants])
    @items     = ItemRepo.new(self, directory[:items])
    @invoices  = InvoiceRepo.new(self, directory[:invoices])
  end

  def find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant(id)
    merchants.find_by_id(id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)    
  end

end
