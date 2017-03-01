require 'pry'
require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/invoice'
require_relative '../lib/invoice_item'
require_relative '../lib/transaction'
require_relative '../lib/customer'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(files_to_be_loaded)
    @merchants ||= MerchantRepository.new(files_to_be_loaded[:merchants], self)
    @items ||= ItemRepository.new(files_to_be_loaded[:items], self)
    @invoices ||= InvoiceRepository.new(files_to_be_loaded[:invoices], self)
    @invoice_items ||= InvoiceItemRepository.new(files_to_be_loaded[:invoice_items], self)
    @transactions ||= TransactionRepository.new(files_to_be_loaded[:transactions], self)
    @customers ||= CustomerRepository.new(files_to_be_loaded[:customers], self)
  end

  def self.from_csv(files_to_be_loaded)
    SalesEngine.new(files_to_be_loaded)
  end
end
