require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'

class SalesEngine


  attr_reader :items, :merchants, :invoices

  def initialize(files)
    @items = ItemRepository.new(files[:items], self)
    @merchants = MerchantRepository.new(files[:merchants], self)
    @invoices = InvoiceRepository.new(files[:invoices], self)
  end

  def self.from_csv(files)
      SalesEngine.new(files)
  end

  def merchant(id)
    merchants.find_by_id(id)
  end

  def find_item(id)
    items.find_by_id(id)
  end

end
