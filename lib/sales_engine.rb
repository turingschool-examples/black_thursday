require_relative 'file_loader'
require_relative 'sales_analyst'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'repo_methods'

class SalesEngine
  include RepoMethods
  attr_reader     :file_path

  def self.from_csv(file_path)
    SalesEngine.new(file_path)
  end

  def initialize(file_path)
    @file_path = file_path
    @file_loader = FileLoader.new(file_path)
  end

  def analyst
    SalesAnalyst.new(self)
    # may want to refactor at a later time
  end

  def merchants
    merchant_file_path = @file_loader.builder(file_path[:merchants])
    @merchants ||= MerchantRepository.new(merchant_file_path)
  end

  def items
    item_file_path = @file_loader.builder(file_path[:items])
    @items ||= ItemRepository.new(item_file_path)
  end

  def invoices
    invoice_file_path = @file_loader.builder(file_path[:invoices])
    @invoices ||= InvoiceRepository.new(invoice_file_path)
  end

  def invoice_items
    invoice_items_file_path = @file_loader.builder(file_path[:invoice_items])
    @invoice_items ||= InvoiceItemRepository.new(invoice_items_file_path)
  end
end
