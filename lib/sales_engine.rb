
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'

require 'pry'

class SalesEngine

  attr_reader :items, :merchants, :invoices,
              :invoice_items, :transactions, :customers

  def initialize(files)
    @items         = ItemRepository.new(files[:items], self)
    @merchants     = MerchantRepository.new(files[:merchants], self)
    @invoices      = InvoiceRepository.new(files[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(files[:invoice_items], self)
    @transactions  = TransactionRepository.new(files[:transactions], self)
    @customers     = CustomerRepository.new(files[:customers], self)
  end

  def self.from_csv(files)
      SalesEngine.new(files)
  end

  def merchant(id)
    merchants.find_by_id(id)
  end

  def find_item_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_invoices(id)
    invoices.find_all_by_merchant_id(id)
  end

  def find_items_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      items.find_by_id(invoice_item.item_id)
    end.uniq
  end

  def find_transactions_by_invoice_id(id)
      transactions.find_all_by_invoice_id(id)
  end

  def find_customer(id)
    customers.find_by_id(id)
  end

  def find_merchants_by_customer_id(id)
    invoices.find_all_by_customer_id(id).map do |invoice|
      merchants.find_by_id(invoice.merchant_id)
    end.uniq
  end

  def find_invoice(id)
    invoices.find_by_id(id)
  end

  def transaction_result(id)
    transactions.find_all_by_invoice_id(id).map do |transaction|
      transaction
    end
  end

  def find_customers_by_merchant_id(id)
    invoices.find_all_by_merchant_id(id).map do |invoice|
      customers.find_by_id(invoice.customer_id)
    end.uniq
  end

  def find_invoice_items_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id)
  end
end
