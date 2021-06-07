require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_analyst'


class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions,
              :analyst

  def initialize(paths)
    @items = ItemRepository.new(paths[:items])
    @merchants = MerchantRepository.new(paths[:merchants])
    @invoices = InvoiceRepository.new(paths[:invoices])
    @invoice_items = InvoiceItemRepository.new(paths[:invoice_items])
    @customers = CustomerRepository.new(paths[:customers])
    @transactions = TransactionRepository.new(paths[:transactions])
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(paths)
    new(paths)
  end
end
