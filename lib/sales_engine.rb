require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'
require 'csv'

class SalesEngine
  def self.from_csv(files)
    items = files[:items]
    merchs = files[:merchants]
    invoices = files[:invoices]
    invoice_items = files[:invoice_items]
    transactions = files[:transactions]
    customers = files[:customers]
    SalesEngine.new(items,merchs,invoices,invoice_items,transactions,customers)
  end

  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions,
              :customers

  def initialize(items,merchants,invoices,invoice_items,transactions,customers)
    @items = ItemRepository.new(items, self)
    @merchants = MerchantRepository.new(merchants, self)
    @invoices = InvoiceRepository.new(invoices, self)
    @invoice_items = InvoiceItemRepository.new(invoice_items, self)
    @transactions = TransactionRepository.new(transactions, self)
    @customers = CustomerRepository.new(customers, self)
  end

  def find_merchant_items(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_item_merchant(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_merchant_invoice(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_for_merchant(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def find_item_ids(invoice_id)
    invoice_items_list = invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_items_list.map do |invoice_item|
      invoice_item.item_id
    end
  end

  def find_items_for_invoices(invoice_id)
    item_ids = find_item_ids(invoice_id)
    item_ids.map do |item_id|
      items.find_by_id(item_id)
    end
  end

  def find_transactions_for_invoice(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_customer_from_invoice(customer_id)
    customers.find_by_id(customer_id)
  end

  def find_invoice_for_transaction(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def find_all_invoices_for_merchant(merchant_id)
    merchs = invoices.find_all_by_merchant_id(merchant_id)
    merchs.map do |merch|
      invoices.find_all_by_merchant_id(merch.merchant_id)
    end
  end

  def find_customer_ids_from_invoice(merchant_id)
    invoices_for_merchant = find_all_invoices_for_merchant(merchant_id).flatten
    invoices_for_merchant.map do |invoice|
      invoice.customer_id
    end
  end

  def find_merchant_customer(merchant_id)
    customer_ids = find_customer_ids_from_invoice(merchant_id)
    customer_ids.map do |customer_id|
      customers.find_by_id(customer_id)
    end.uniq
  end

  def find_merchant_ids_from_invoice(customer_id)
    invoices_for_customer = find_all_invoices_for_customer(customer_id).flatten
    invoices_for_customer.map do |invoice|
      invoice.merchant_id
    end
  end

  def find_all_invoices_for_customer(customer_id)
    custs = invoices.find_all_by_customer_id(customer_id)
    custs.map do |cust|
      invoices.find_all_by_customer_id(cust.customer_id)
    end
  end

  def find_merchant_ids_from_invoice(customer_id)
    custs_invoices = find_all_invoices_for_customer(customer_id).flatten
    custs_invoices.map do |cust|
      cust.merchant_id
    end
  end

  def find_customer_merchant(customer_id)
    merchant_ids = find_merchant_ids_from_invoice(customer_id)
    merchant_ids.map do |merchant_id|
      merchants.find_by_id(merchant_id)
    end
  end

  def total_invoice_amount(invoice_id)
    successful_i_items = invoice_items.find_all_by_invoice_id(invoice_id)
    successful_i_items.map do |i_item|
      i_item.total
    end.sum.round(2)
  end
end
