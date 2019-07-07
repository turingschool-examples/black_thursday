require_relative 'file_loader'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'sales_analyst'
require_relative 'invoice_item_repository'

class SalesEngine
  include FileLoader

  attr_reader :data_files

  def initialize(data_files)
    @data_files = data_files
  end

  def self.from_csv(data_files)
    new(data_files)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def merchants
    @merchants ||= MerchantRepository.new(load_file(data_files[:merchants]))
  end

  def items
    @items ||= ItemRepository.new(load_file(data_files[:items]))
  end

  def invoices
    @invoices ||= InvoiceRepository.new(load_file(data_files[:invoices]))
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(load_file(data_files[:invoice_items]))
  end

  def transactions
    @transactions ||= TransactionRepository.new(load_file(data_files[:transactions]))
  end

  def customers
    @customers ||= CustomerRepository.new(load_file(data_files[:customers]))
  end
end
