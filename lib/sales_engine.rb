require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :files,
              :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(files)
    @files         = files
    @merchants     = MerchantRepository.new(files[:merchants], self)
    @items         = ItemRepository.new(files[:items], self)
    @invoices      = InvoiceRepository.new(files[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(files[:invoice_items], self)
    @transactions  = TransactionRepository.new(files[:transactions], self)
    @customers     = CustomerRepository.new(files[:customers], self)
  end

  def self.from_csv(files)
    new(files)
  end

  def items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def merchant_by_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def invoices_by_merchant_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def items_by_invoice_id(invoice_id)
    invoice_items = @invoice_items.find_all_by_invoice_id(invoice_id)
    @items.find_items_by_invoice_id(invoice_items)
  end

  def transactions_by_invoice_id(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end

end
