require "csv"
require_relative "../lib/item_repo"
require_relative "../lib/merchant_repo"
require_relative "../lib/invoice_repo"
require_relative "../lib/transaction_repo"
require_relative "../lib/customer_repo"
require_relative "../lib/invoice_item_repo"

class SalesEngine

  def self.from_csv(files)
    SalesEngine.new(files)
  end

  def initialize(files)
    @files = files
  end

  def merchants
    @merchants ||= MerchantsRepo.new(@files[:merchants], self)
  end

  def items
    @items ||= ItemRepo.new(@files[:items], self)
  end

  def invoices
    @invoices ||= InvoiceRepo.new(@files[:invoices], self)
  end

  def transactions
    @transactions ||= TransactionRepo.new(@files[:transactions], self)
  end

  def customers
    @customers ||= CustomerRepo.new(@files[:customers], self)
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepo.new(@files[:invoice_items], self)
  end

  def find_merchant_by_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_customer_by_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_invoice_by_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_all_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_all_invoice_items_by_invoice_id(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_all_items_by_invoice_id(invoice_id)
    invoiced_items = invoice_items.find_all_by_invoice_id(invoice_id)
    invoiced_items.map {|invoice_item| items.find_by_id(invoice_item.item_id)}
  end

  def find_all_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_all_merchants_by_customer_id(customer_id)
    invoice_list = invoices.find_all_by_cusotmer_id(customer_id)
    invoice_list.map do |invoice|
      merchants.find_merchant_by_id(invoice.merchant_id)
    end
  end

  def find_all_customers_by_merchant_id(merchant_id)
    invoices = find_all_invoices_by_merchant_id(merchant_id)
    customers_ids = invoices.map {|invoice| invoice.customer_id}
    customers_ids.map do |customer|
      customers.find_by_id(customer)
    end.uniq
  end
end
