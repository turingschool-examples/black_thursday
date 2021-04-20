require 'CSV'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_analyst'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :customers,
              :transactions,
              :analyst

  def initialize(csv_data)
    @merchants = MerchantRepository.new(csv_data[:merchants])
    @items = ItemRepository.new(csv_data[:items])
    @invoices = InvoiceRepository.new(csv_data[:invoices])
    @invoice_items = InvoiceItemRepository.new(csv_data[:invoice_items])
    # @customers = CustomerRepository.new(csv_data[:customers])
    # @transactions = TransactionRepository.new(csv_data[:transactions])
    # @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(csv_data)
     SalesEngine.new(csv_data)
  end
end
