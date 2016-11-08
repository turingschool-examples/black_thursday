require_relative './merchant_repo'
require_relative './item_repo'
require_relative './invoice_repo'
require_relative './invoice_item_repo'
require_relative './transaction_repo'
require_relative './customer_repo'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(file_path)
    @merchants     = MerchantRepo.new(file_path[:merchants], self)
    @items         = ItemRepo.new(file_path[:items], self)
    @invoices      = InvoiceRepo.new(file_path[:invoices], self)
    @invoice_items = InvoiceItemRepo.new(file_path[:invoice_items], self)
    @transactions  = TransactionRepo.new(file_path[:transactions], self)
    @customers     = CustomerRepo.new(file_path[:customers], self)
  end

  def self.from_csv(file_path)
    SalesEngine.new(file_path)
  end

  def find_merchant_by_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def find_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_invoices_by_merchant_id(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    @invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_merchant_by_invoice_id(invoice_id)
    @merchants.find_by_id(invoice_id)
  end

  def find_item_by_item_id(item_id)
    @items.find_by_id(item_id)
  end

  def find_transactions_by_invoice_id(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_by_customer_id(customer_id)
    @customers.find_by_id(customer_id)
  end

  def find_invoice_by_invoice_id(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def find_invoices_by_customer_id(customer_id)
    @invoices.find_all_by_customer_id(customer_id)
  end

  def all_merchants
    @merchants.all.count
  end

  def all_items
    @items.all.count
  end

  def all_invoices
    @invoices.all.count
  end
end
