require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoice_items,
              :customers,
              :transactions,
              :analyst

  def initialize(paths)
    @items     = ItemRepository.new(paths[:items])
    @merchants = MerchantRepository.new(paths[:merchants])
    @invoice_items = InvoiceItemRepository.new(paths[:invoice_items])
    @customers = CustomerRepository.new(paths[:customers])
    @transactions = TransactionRepository.new(path[:transactions])
    @analyst   = SalesAnalyst.new(self)
  end

  def self.from_csv(paths)
    new(paths)
  end
end
