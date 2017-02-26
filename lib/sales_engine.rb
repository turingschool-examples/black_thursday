require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_accessor :merchants, :items, :invoices

  def self.from_csv(info)
    @merchants_repo = MerchantRepository.new(info[:merchants], self)
    @items_repo = ItemRepository.new(info[:items], self)
    @invoices_repo = InvoiceRepository.new(info[:invoices], self)
    self
  end

  def self.merchants
    @merchants_repo
  end

  def self.items
    @items_repo
  end
  
  def self.invoices
    @invoices_repo
  end

end
