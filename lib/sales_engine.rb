require 'csv'
require 'bigdecimal'
require_relative 'file_loader.rb'
require_relative 'merchant_repository.rb'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository.rb'
require_relative 'transaction_repository'
require_relative 'sales_analyst'
require_relative 'sales_engine'
require_relative 'file_loader'
class SalesEngine
  include FileLoader
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions
  def initialize(file_paths)
    @file_paths = file_paths
    @merchants ||= MerchantRepository.new(load(file_paths[:merchants]))
    @items ||= ItemRepository.new(load(file_paths[:items]))
    @invoices ||= InvoiceRepository.new(load(file_paths[:invoices]))
    @invoice_items ||= InvoiceItemRepository.new(load(file_paths[:invoice_items]))
    @transactions ||= TransactionRepository.new(load(file_paths[:transactions]))
  end
  def self.from_csv(file_paths)
    SalesEngine.new(file_paths)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end
