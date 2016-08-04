require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require 'csv'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(items_path,
                 merchants_path,
                 invoices_path,
                 invoice_items_path,
                 transactions_path,
                 customers_path)
    @items = ItemRepository.new(rows(items_path), self)
    @merchants = MerchantRepository.new(rows(merchants_path), self)
    @invoices = InvoiceRepository.new(rows(invoices_path), self)
    @invoice_items = InvoiceItemRepository.new(rows(invoice_items_path), self)
    @transactions = TransactionRepository.new(rows(transactions_path), self)
    @customers = CustomerRepository.new(rows(customers_path), self)
  end

  def rows(path)
    file = CSV.open(path, headers: true, header_converters: :symbol)
    file.to_a
  end

  def self.from_csv(data)
    new(data[:items],         data[:merchants],    data[:invoices],
        data[:invoice_items], data[:transactions], data[:customers])
  end

  def find_merchant_by_id(m_id)
    merchants.find_by_id(m_id)
  end

  def find_invoice_by_id(inv_id)
    invoices.find_by_id(inv_id)
  end

  def find_customer_by_id(cust_id)
    customers.find_by_id(cust_id)
  end

  def find_all_items_by_merchant_id(m_id)
    items.find_all_by_merchant_id(m_id)
  end

  def find_all_invoices_by_merchant_id(m_id)
    invoices.find_all_by_merchant_id(m_id)
  end

  def find_all_invoices_by_customer_id(c_id)
    invoices.find_all_by_customer_id(c_id)
  end

  def find_all_invoices_by_status(status)
    invoices.find_all_by_status(status)
  end

  def find_all_customers_by_merchant_id(m_id)
    invoices = find_all_invoices_by_merchant_id(m_id)
    cust_ids = invoices.map { |inv| inv.customer.id }
    all_customers.find_all { |cust| cust_ids.include? cust.id }
  end

  def find_all_merchants_by_customer_id(c_id)
    invoices.find_all_merchants_by_customer_id(c_id)
  end

  def find_items_by_invoice_id(invoice_id)
    inv_items = invoice_items.find_all_by_invoice_id(invoice_id)
    item_ids = inv_items.map(&:item_id)
    all_items.find_all { |item| item_ids.include? item.id }
  end

  def find_invoice_items_by_invoice_id(invoice_id)
    invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def find_total_item_quantity_by_invoice_id(invoice_id)
    find_invoice_items_by_invoice_id(invoice_id).map(&:quantity).reduce(&:+)
  end

  def find_transactions_by_invoice_id(invoice_id)
    transactions.find_all_by_invoice_id(invoice_id)
  end

  def find_fully_paid_invoices_by_customer_id(cust_id)
    cust_invoices = invoices.find_all_by_customer_id(cust_id)
    cust_invoices.select(&:is_paid_in_full?)
  end

  def all_merchants
    merchants.all
  end

  def all_items
    items.all
  end

  def all_invoices
    invoices.all
  end

  def paid_invoices
    all_invoices.select(&:is_paid_in_full?)
  end

  def all_customers
    customers.all
  end

  def total_merchants
    all_merchants.length
  end

  def total_items
    all_items.length
  end

  def total_invoices
    all_invoices.length
  end

  def items_per_merchant
    all_merchants.map { |m| m.items.length }
  end

  def invoices_per_merchant
    all_merchants.map { |m| m.invoices.length }
  end

  def merchants_with_item_count_over_n(n)
    all_merchants.select { |m| m.items.length > n }
  end

  def merchants_with_invoice_count_over_n(n)
    all_merchants.select { |m| m.invoices.length > n }
  end

  def merchants_with_invoice_count_under_n(n)
    all_merchants.select { |m| m.invoices.length < n }
  end

  def items_with_price_over_n(n)
    all_items.select { |i| i.unit_price > n }
  end

  def total_invoices_by_weekday
    group_invoices = all_invoices.group_by(&:weekday_created)
    group_invoices.map { |day, invoices| [day, invoices.length] }.to_h
  end
end
