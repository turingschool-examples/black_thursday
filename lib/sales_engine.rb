require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'

# Data Access Layer that interacts with repositories
class SalesEngine
  attr_accessor :items,
                :merchants,
                :invoices,
                :transactions

  def initialize(repositories)
    @items = ItemRepository.new(repositories[:items], self)
    @merchants = MerchantRepository.new(repositories[:merchants], self)
    @invoices = InvoiceRepository.new(repositories[:invoices])
    @transactions = TransactionRepository.new(repositories[:transactions], self)
  end

  def self.from_csv(repositories)
    new(repositories)
  end

  def find_merchant_items(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_item_merchant(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_transaction_invoice(invoice_id)
    @invoices.find_by_id(invoice_id)
  end
end
