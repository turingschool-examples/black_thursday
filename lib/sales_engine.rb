require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions

  def self.from_csv(sales_info)
    new(sales_info)
  end

  def initialize(sales_info)
    @items         = make_item_repo(sales_info)
    @merchants     = make_merchant_repo(sales_info)
    @invoices      = make_invoice_repo(sales_info)
    @invoice_items = make_invoice_item_repo(sales_info)
    @customers     = make_customer_repo(sales_info)
    @transactions  = make_transaction_repo(sales_info)
  end

  def make_item_repo(sales_info)
    ItemRepository.new(sales_info[:items], self)
  end

  def make_merchant_repo(sales_info)
    MerchantRepository.new(sales_info[:merchants], self)
  end

  def make_invoice_repo(sales_info)
    InvoiceRepository.new(sales_info[:invoices], self)
  end

  def make_invoice_item_repo(sales_info)
    InvoiceItemRepository.new(sales_info[:invoice_items], self)
  end

  def make_customer_repo(sales_info)
    CustomerRepository.new(sales_info[:customers], self)
  end

  def make_transaction_repo(sales_info)
    TransactionRepository.new(sales_info[:transactions], self)
  end

  def find_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_invoices(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_by_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_item_by_id(item_id)
    items.find_by_id(item_id)
  end

  def find_customer_by_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_items_by_invoice_id(invoice_id)
    collection = invoice_items.find_all_by_invoice_id(invoice_id)
    collection.map { |invoice_item| invoice_item.item }.compact
  end

  def find_customers_of_merchant(merchant_id)
    collection = invoices.find_all_by_merchant_id(merchant_id)
    collection.map { |invoice| invoice.customer }.uniq
  end

  def all_items
    items.all
  end

  def all_merchants
    merchants.all
  end

  def all_invoices
    invoices.all
  end

  def all_invoice_items
    invoice_items.all
  end

  def all_customers
    customers.all
  end

  def all_transactions
    transactions.all
  end

end
