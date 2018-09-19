require_relative 'file_loader'
require_relative 'merchant_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'transaction'
require_relative 'transaction_repository'

require_relative 'sales_analyst'
class SalesEngine
    attr_reader :merchants, :items, :invoices, :invoice_items, :transactions, :customers, :sales_analyst

  def initialize(path_1, path_2, path_3, path_4, path_5, path_6)
    @merchants = MerchantRepository.new(path_2)
    @items = ItemRepository.new(path_1)
    @invoices = InvoiceRepository.new(path_3)
    @invoice_items = InvoiceItemRepository.new(path_4)
    @transactions = TransactionRepository.new(path_5)
    @customers = CustomerRepository.new(path_6)
  end

  def self.from_csv(data)
    self.new(data[:items], data[:merchants], data[:invoices], data[:invoice_items], data[:transactions], data[:customers])
  end

  def analyst
    @sales_analyst = SalesAnalyst.new(self)
  end
end
