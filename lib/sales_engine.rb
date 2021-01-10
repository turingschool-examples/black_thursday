require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'


class SalesEngine
  attr_reader :items, :merchants, :analyst, :invoices, :invoice_items, :transactions, :customers

  def self.from_csv(arg1)

    new(arg1)
  end

  def initialize(arg1)
    @items = ItemRepository.new(arg1[:items], self)
    @merchants = MerchantRepository.new(arg1[:merchants], self)
    @analyst = SalesAnalyst.new(self)
    @invoices = InvoiceRepository.new(arg1[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(arg1[:invoice_items], self)
    @transactions = TransactionRepository.new(arg1[:transactions], self)
    @customers = CustomerRepository.new(arg1[:customers], self)
  end

  def all_merchants
   @merchants.all
  end

  def find_all_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def all_items
    @items.all
  end

  def all_invoices
    @invoices.all
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    @invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_transaction_by_invoice_id(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end
end
