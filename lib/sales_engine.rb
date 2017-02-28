require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'file_loader'


class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(file_paths)
    @items = ItemRepository.new(FileLoader.load_csv(file_paths[:items]), self)
    @merchants = MerchantRepository.new(FileLoader.load_csv(file_paths[:merchants]), self)
    @invoices = InvoiceRepository.new(FileLoader.load_csv(file_paths[:invoices]), self)
    @invoice_items = InvoiceItemRepository.new(FileLoader.load_csv(file_paths[:invoice_items]), self)
    @transactions = TransactionRepository.new(FileLoader.load_csv(file_paths[:transactions]), self)
    @customers = CustomerRepository.new(FileLoader.load_csv(file_paths[:customers]), self)
  end

  def self.from_csv(file_paths)
    SalesEngine.new(file_paths)
  end

end
