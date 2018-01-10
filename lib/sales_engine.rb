require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'

require 'pry'

class SalesEngine

  attr_reader :items, :merchants, :invoices,
              :invoice_items, :customers, :transactions

  def initialize(files)
    @items         = ItemRepository.new(files[:items], self)
    @merchants     = MerchantRepository.new(files[:merchants], self)
    @invoices      = InvoiceRepository.new(files[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(files[:invoice_items], self)
    @transactions  = TransactionRepository.new(files[:transactions], self)
    @customers = CustomerRepository.new(files[:customers], self)
  end

  def self.from_csv(files)
      SalesEngine.new(files)
  end

  def merchant(id)
    merchants.find_by_id(id)
  end

  def find_item(id)
    items.find_all_by_merchant_id(id)
  end

  def find_invoices(id)
    invoices.find_all_by_merchant_id(id)
  end

end
