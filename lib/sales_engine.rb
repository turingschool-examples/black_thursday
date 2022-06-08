require_relative "merchant_repository"
require_relative "item_repository"
require_relative "sales_analyst"
require_relative "invoice_repository"
require_relative "invoice_item_repository"
require_relative "transaction_repository"


class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :analyst,
              :invoice_items,
              :transactions

  def initialize(file_paths)
    @items = ItemRepository.new(file_paths[:items])
    @merchants = MerchantRepository.new(file_paths[:merchants])
    @invoices = InvoiceRepository.new(file_paths[:invoices])
    @analyst = SalesAnalyst.new(@items, @merchants)
    @invoice_items = InvoiceItemRepository.new(file_paths[:invoice_items])
    @transactions = TransactionRepository.new(file_paths[:transactions])
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end
end
