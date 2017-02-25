require 'pry'
require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/customer'
require_relative '../lib/invoice'
require_relative '../lib/invoice_item'
require_relative '../lib/transaction'


class SalesEngine
  attr_reader :merchants, :items, :customers, :invoices, :invoice_items, :transactions

  def initialize(files_to_be_loaded)
    @merchants ||= MerchantRepository.new(files_to_be_loaded[:merchants])
    @items ||= ItemRepository.new(files_to_be_loaded[:items])
    @customers ||= CustomerRepository.new(files_to_be_loaded[:customers])
    @invoices ||= InvoiceRepository.new(files_to_be_loaded[:invoices])
    @invoice_items ||= InvoiceItemRepository.new(files_to_be_loaded[:invoice_items])
    @transactions ||= TransactionRepository.new(files_to_be_loaded[:transactions])
  end

  def self.from_csv(files_to_be_loaded)
    SalesEngine.new(files_to_be_loaded)
  end
end
