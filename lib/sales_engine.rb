require_relative "item_repository"
require_relative "merchant_repository"
require_relative "invoice_repository"
require_relative "invoice_item_repository"
require_relative "transaction_repository"
require_relative "customer_repository"
require_relative "../lib/merchant_link_generator"
require "bigdecimal"
require 'pry'

class SalesEngine
  include MerchantRelationshipGenerator

  attr_reader :merchants,
              :items,
              :invoices,
              :transactions,
              :customers,
              :invoice_items,
              :merchants_with_items,
              :merchants_with_prices,
              :merchants_with_invoices,
              :merchant_ids_with_total_revenue

  def initialize(file_paths)
    @merchants     ||= MerchantRepository.new(file_paths[:merchants], self)
    @items         ||= ItemRepository.new(file_paths[:items], self)
    @invoices      ||= InvoiceRepository.new(file_paths[:invoices], self)
    @invoice_items ||= InvoiceItemRepository.new(file_paths[:invoice_items], self)
    @transactions  ||= TransactionRepository.new(file_paths[:transactions], self)
    @customers     ||= CustomerRepository.new(file_paths[:customers], self)
    generate_merchant_relationships
  end

  def self.from_csv(file_paths)
    self.new(file_paths)
  end

  def get_merchant_from_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def get_items_from_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def get_invoices_from_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

  def get_transactions_from_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def get_customer_from_customer_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def get_invoice_from_invoice_id(invoice_id)
    invoices.find_by_id(invoice_id)
  end

  def get_item_ids_from_invoice_id(invoice_id)
    invoice_item_array = invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_item_array.map do |invoice_item|
      invoice_item.item_id
    end
  end

  def get_items_from_invoice_id(invoice_id)
    item_ids = get_item_ids_from_invoice_id(invoice_id)
    item_ids.map do |item_id|
      items.find_by_id(item_id)
    end
  end

  def get_customer_ids_from_merchant_id(merchant_id)
    merchant_invoices = invoices.find_all_by_merchant_id(merchant_id)
    merchant_invoices.map do |invoice|
      invoice.customer_id
    end.uniq
  end

  def get_customers_from_merchant_id(merchant_id)
    customer_ids = get_customer_ids_from_merchant_id(merchant_id)
    customer_ids.map do |customer_id|
      customers.find_by_id(customer_id)
    end
  end

  def get_merchant_ids_from_customer_ids(customer_id)
    customer_invoices = invoices.find_all_by_customer_id(customer_id)
    customer_invoices.map do |invoice|
      invoice.merchant_id
    end.uniq
  end

  def get_merchants_from_customer_id(customer_id)
    merchant_ids = get_merchant_ids_from_customer_ids(customer_id)
    merchant_ids.map do |merchant_id|
      merchants.find_by_id(merchant_id)
    end
  end

  def get_items_by_price(price)
    items.find_all_by_price(price)
  end

  def get_invoice_total(invoice_id)
    invoice_item_array = invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_item_array.reduce(0) do |total, invoice_item|
      total + (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  def is_invoice_paid_in_full?(invoice_id)
    invoice_transactions = get_transactions_from_invoice_id(invoice_id)
    return false if invoice_transactions.empty?
    invoice_transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def get_invoice_ids_by_date(date)
    invoices_array = invoices.find_by_date(date)
    invoices_array.map do |invoice|
      invoice.id
    end
  end

  def get_invoice_items_by_date(date)
    invoice_ids_array = get_invoice_ids_by_date(date)
    invoice_ids_array.map do |invoice_id|
      invoice_items.find_all_by_invoice_id(invoice_id)
    end.flatten
  end

  def get_invoice_items_total_cost_by_date(date)
    get_invoice_items_by_date(date).map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
  end

  def get_merchant_ids_with_pending_invoices
    invoices.all.map do |invoice|
      invoice.merchant_id unless invoice.is_paid_in_full?
    end.uniq.compact
  end

  def get_merchants_with_pending_invoices
    get_merchant_ids_with_pending_invoices.map do |merchant_id|
      merchants.find_by_id(merchant_id)
    end
  end

end
