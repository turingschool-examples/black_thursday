require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

# Data Access Layer that interacts with repositories
class SalesEngine
  attr_accessor :items,
                :merchants,
                :invoices

  def initialize(repositories)
    @items = ItemRepository.new(repositories[:items], self)
    @merchants = MerchantRepository.new(repositories[:merchants], self)
    @invoices = InvoiceRepository.new(repositories[:invoices])
  end

  def self.from_csv(repositories)
    new(repositories)
  end

  def find_merchant_items(id)
    @items.find_all_by_merchant_id(id)
  end

  def find_item_merchant(id)
    @merchants.find_by_id(id)
  end
end
