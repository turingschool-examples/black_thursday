# frozen_string_literal: false

require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'sales_analyst'
require_relative 'file_reader'
# Responsible for establishing each repository, which establishes each object
class SalesEngine
  include FileReader

  def initialize(path)
    @path = path
  end

  def self.from_csv(path)
    new(path)
  end

  def merchants
    file_path = @path[:merchants]
    @merchants ||= MerchantRepository.new(FileReader.load(file_path))
  end

  def items
    file_path = @path[:items]
    @items ||= ItemRepository.new(FileReader.load(file_path))
  end

  def invoices
    file_path = @path[:invoices]
    @invoices ||= InvoiceRepository.new(FileReader.load(file_path))
  end

  def invoice_items
    file_path = @path[:invoice_items]
    @invoice_items ||= InvoiceItemRepository.new(FileReader.load(file_path))
  end

  def transactions
    file_path = @path[:transactions]
    @transactions ||= TransactionRepository.new(FileReader.load(file_path))
  end

  def customers
    file_path = @path[:customers]
    @customers ||= CustomerRepository.new(FileReader.load(file_path))
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
