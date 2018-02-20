require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

# Data Access Layer that interacts with repositories
class SalesEngine
  attr_accessor :items, :merchants, :invoices 

  def initialize(repositories)
    @items = ItemRepository.new(repositories[:items])
    @merchants = MerchantRepository.new(repositories[:merchants])
    @invoices = InvoiceRepository.new(repositories[:invoices])
  end

  def self.from_csv(repositories)
    new(repositories)
  end
end
