require 'csv'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'



class SalesEngine

  def self.from_csv(data)
    @invoices = InvoiceRepository.new(data[:invoices], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @items = ItemRepository.new(data[:items], self)
    @invoice_items = InvoiceItemRepository.new(data[:invoice_items], self)
    @transactions = TransactionRepository.new(data[:transactions], self)
    @customers = CustomerRepository.new(data[:customers], self)
    self
  end

  def self.items
    @items
  end

  def self.merchants
    @merchants
  end

  def self.invoices
    @invoices
  end

  def self.invoice_items
    @invoice_items
  end

  def self.transactions
    @transactions
  end

  def self.customers
    @customers
  end

  def self.find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def self.find_merchant_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def self.find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def self.find_customer_by_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def self.find_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def self.find_invoice_items_by_invoice_id(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def self.find_item_by_item_id(item_id)
    items.find_by_id(item_id)
  end

end