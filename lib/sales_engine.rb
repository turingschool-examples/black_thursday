require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
<<<<<<< HEAD
require_relative 'transaction_repository'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :transactions

  def initialize(items_path, merchants_path, invoices_path, transactions_path)
    @items = ItemRepository.new(csv_rows(items_path), self)
    @merchants = MerchantRepository.new(csv_rows(merchants_path), self)
    @invoices = InvoiceRepository.new(csv_rows(invoices_path), self)
    @transactions = TransactionRepository.new(csv_rows(transactions_path), self)
=======
require_relative 'invoice_item_repository'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items

  def initialize(items_path, merchants_path, invoices_path, invoice_items_path)
    @items = ItemRepository.new(csv_rows(items_path), self)
    @merchants = MerchantRepository.new(csv_rows(merchants_path), self)
    @invoices = InvoiceRepository.new(csv_rows(invoices_path), self)
    @invoice_items = InvoiceItemRepository.new(csv_rows(invoice_items_path), self)
>>>>>>> iter2
  end

  def csv_rows(path)
    file = CSV.open(path, headers: true, header_converters: :symbol)
    file.to_a
  end

  def self.from_csv(data)
    items_path = data[:items]
    merchants_path = data[:merchants]
    invoices_path = data[:invoices]
<<<<<<< HEAD
    transactions_path = data[:transactions]
    self.new(items_path, merchants_path, invoices_path, transactions_path)
=======
    invoice_items_path = data[:invoice_items]
    self.new(items_path, merchants_path, invoices_path, invoice_items_path)
>>>>>>> iter2
  end

  def find_merchant_by_id(m_id)
    merchants.find_by_id(m_id)
  end

  def find_invoice_by_id(inv_id)
    invoices.find_by_id(inv_id)
  end

  def find_all_items_by_merchant_id(m_id)
    items.find_all_by_merchant_id(m_id)
  end

  def find_all_invoices_by_merchant_id(m_id)
    invoices.find_all_by_merchant_id(m_id)
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
    invoices = all_invoices.group_by { |inv| inv.weekday_created }
    invoices.map { |day, invoices| [day, invoices.length]}.to_h
  end
end
