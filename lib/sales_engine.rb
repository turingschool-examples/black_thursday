require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants, :invoices

  def initialize(items_path, merchants_path, invoices_path)
    @items = ItemRepository.new(csv_rows(items_path), self)
    @merchants = MerchantRepository.new(csv_rows(merchants_path), self)
    @invoices = InvoiceRepository.new(csv_rows(invoices_path), self)
  end

  def csv_rows(path)
    file = CSV.open(path, headers: true, header_converters: :symbol)
    file.to_a
  end

  def self.from_csv(data)
    items_path = data[:items]
    merchants_path = data[:merchants]
    invoices_path = data[:invoices]
    self.new(items_path, merchants_path, invoices_path)
  end

  def find_merchant_by_id(m_id)
    merchants.find_by_id(m_id)
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

  def total_merchants
    all_merchants.length
  end

  def total_items
    all_items.length
  end

  def items_per_merchant
    all_merchants.map { |m| m.items.length }
  end

  def merchants_with_item_count_over_n(n)
    all_merchants.select { |m| m.items.length > n }
  end

  def items_with_price_over_n(n)
    all_items.select { |i| i.unit_price > n }
  end



end
