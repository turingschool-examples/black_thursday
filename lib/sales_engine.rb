require_relative 'file_loader'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  include FileLoader
  attr_reader :file_paths

  def initialize(file_paths)
    @file_paths = file_paths
  end

  def self.from_csv(file_hash)
    new(file_hash)
  end

  def merchants
    @merchants ||= MerchantRepository.new(load_file(file_paths[:merchants]), self)
  end

  def items
    @items ||= ItemRepository.new(load_file(file_paths[:items]), self)
  end

  def analyst
    @analyst ||= SalesAnalyst.new(self)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(load_file(file_paths[:invoices]))
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(load_file(file_paths[:invoice_items]))
  end

  def transactions
    @transactions ||= TransactionRepository.new(load_file(file_paths[:transactions]))
  end

  def customers
    @customers ||= CustomerRepository.new(load_file(file_paths[:customers]))
  end

end
