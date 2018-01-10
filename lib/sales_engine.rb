require_relative "item_repository"
require_relative "merchant_repository"
require_relative "invoice_repository"
require_relative "invoice_item_repository"
require_relative "transaction_repository"
require_relative "customer_repository"
require "bigdecimal"
require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :transactions,
              :customers,
              :invoice_items,
              :merchants_with_items

  def initialize(file_paths)
    @merchants     ||= MerchantRepository.new(file_paths[:merchants], self)
    @items         ||= ItemRepository.new(file_paths[:items], self)
    @invoices      ||= InvoiceRepository.new(file_paths[:invoices], self)
    @invoice_items ||= InvoiceItemRepository.new(file_paths[:invoice_items], self)
    @transactions  ||= TransactionRepository.new(file_paths[:transactions], self)
    @customers     ||= CustomerRepository.new(file_paths[:customers], self)
    generate_relationships
  end

  def generate_relationships
    @merchant_ids_with_invoice_ids   ||= get_merchant_ids_and_invoice_ids_from_invoices
    #change name to associate merchant ids with invoice items (assoc for hash, get for array)
    @merchant_ids_with_invoice_items ||= transform_invoice_ids_to_invoice_items
    @merchants_with_items            ||= get_all_merchant_items
  end

  def get_merchant_ids_and_invoice_ids_from_invoices
    merchant_ids_and_invoice_ids = Hash.new { |hash, key| hash[key] = [] }
    invoices.all.each do |invoice|
        merchant_ids_and_invoice_ids[invoice.merchant_id] << invoice.id if invoice.is_paid_in_full?
      end
    merchant_ids_and_invoice_ids
  end

  def get_all_merchant_invoices
    merchants_and_invoices = {}
    merchants.all.map do |merchant|
      merchants_and_invoices[merchant] = get_invoices_from_merchant_id(merchant.id)
    end
    merchants_and_invoices
  end

  def get_all_merchant_items
    merchants_and_items = {}
    merchants.all.map do |merchant|
      merchants_and_items[merchant] = items.find_all_by_merchant_id(merchant.id)
    end
    merchants_and_items
  end

  def transform_invoice_ids_to_invoice_items
    @merchant_ids_with_invoice_ids.transform_values do |invoice_ids|
      invoice_ids.map do |invoice_id|
        invoice_items.find_all_by_invoice_id(invoice_id)
      end.flatten
    end
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

  def get_transactions_from_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def get_customer_from_customer_id(customer_id)
    customers.find_by_id(customer_id)
  end

  def get_invoice_from_invoice_id(invoice_id)
    invoices.find_by_id(invoice_id)
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

  def get_all_merchant_prices
    merchants_with_items.transform_values do |item_array|
      item_array.map do |item|
        item.unit_price
      end
    end
  end

  def get_one_merchant_prices(merchant_id)
    get_all_merchant_prices.find do |merchant, prices|
      merchant.id == merchant_id
    end.last.flatten
  end

  def search_ir_by_price(price)
    items.find_all_by_price(price)
  end

  def is_invoice_paid_in_full?(invoice_id)
    invoice_transactions = get_transactions_from_invoice_id(invoice_id)
    return false if invoice_transactions.empty?
    invoice_transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def get_invoice_total(invoice_id)
    invoice_item_array = invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_item_array.reduce(0) do |total, invoice_item|
      total + (invoice_item.quantity * invoice_item.unit_price)
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

  def transform_invoice_items_to_total_revenue_per_merchant
    @merchant_ids_with_invoice_items.transform_values do |invoice_items|
      invoice_items.map do |invoice_item|
        invoice_item.unit_price * invoice_item.quantity
      end.sum
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

  def missing_merchant_ids
    merchant_ids = Hash.new { |hash, key| hash[key] = [] }
    invoices.all.each do |invoice|
        merchant_ids[invoice.merchant_id] = 0 if !invoice.is_paid_in_full?
      end
    merchant_ids
  end

  def merchant_ids_with_item_ids_and_quantities
    @merchant_ids_with_invoice_items.transform_values do |invoice_items|
      item_ids_with_quantities = Hash.new(0)
      invoice_items.map do |invoice_item|
        if invoice_item.quantity > item_ids_with_quantities[invoice_item.item_id]
          item_ids_with_quantities[invoice_item.item_id] = invoice_item.quantity
        end
      end
      item_ids_with_quantities
    end
  end

  def merchant_ids_with_most_sold_item_ids
    merchant_ids_with_item_ids_and_quantities.transform_values do |item_ids_with_qtys|
      item_ids_with_qtys.select do |item_id, qty|
        qty == item_ids_with_qtys.max_by {|ii, q| q}[1]
      end.keys
    end
  end

  def merchant_ids_with_most_sold_items
    merchant_ids_with_most_sold_item_ids.transform_values do |item_ids|
      item_ids.map {|item_id| items.find_by_id(item_id)}
    end
  end

  def merchant_ids_with_item_ids_and_revenue
    @merchant_ids_with_invoice_items.transform_values do |invoice_items|
      item_ids_with_revenue = Hash.new(0)
      invoice_items.map do |invoice_item|
        revenue = invoice_item.unit_price * invoice_item.quantity
        item_ids_with_revenue[invoice_item.item_id] += revenue
      end
      item_ids_with_revenue
    end
  end

  def merchant_ids_with_best_item_ids
    merchant_ids_with_item_ids_and_revenue.transform_values do |item_ids_with_revenue|
      item_ids_with_revenue.select do |item_id, revenue|
        revenue == item_ids_with_revenue.values.max
      end.to_a.flatten.first
    end
  end

  def merchant_ids_with_best_items
    merchant_ids_with_best_item_ids.transform_values do |item_id|
      items.find_by_id(item_id)
    end
  end

end
