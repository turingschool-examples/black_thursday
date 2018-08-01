require_relative 'file_loader'
require_relative 'sales_analyst'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'repo_methods'

class SalesEngine
  include RepoMethods
  include FileLoader
  attr_reader     :file_path

  def self.from_csv(file_path)
    SalesEngine.new(file_path)
  end

  def initialize(file_path)
    @file_path = file_path
  end

  def analyst
    @analyst = SalesAnalyst.new(self)
    # may want to refactor at a later time
  end

  def merchants
    @merchants ||= MerchantRepository.new(builder(file_path[:merchants]))
  end

  def items
    @items ||= ItemRepository.new(builder(file_path[:items]))
  end

  def invoices
    @invoices ||= InvoiceRepository.new(builder(file_path[:invoices]))
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(builder(file_path[:invoice_items]))
  end

  def transactions
    @transactions ||= TransactionRepository.new(builder(file_path[:transactions]))
  end

  def customers
    @customers ||= CustomerRepository.new(builder(file_path[:customers]))
  end
end
