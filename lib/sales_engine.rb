require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'sales_analyst'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions
  def initialize(path)
    @items = ItemRepository.new(path[:items])
    @merchants = MerchantRepository.new(path[:merchants])
    @invoices = InvoiceRepository.new(path[:invoices])
    @invoice_items = InvoiceItemRepository.new(path[:invoice_items])
    @transactions = TransactionRepository.new(path[:transactions])
  end

  def self.from_csv(path)
    new(path)
  end

  def analyst
    SalesAnalyst.new
  end



  def fj
  end


end
