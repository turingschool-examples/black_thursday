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
              :invoices

  def initialize(file_paths)
    @merchants = MerchantRepository.new(file_paths[:merchants], self)
    @items     = ItemRepository.new(file_paths[:items], self)
    @invoices  = InvoiceRepository.new(file_paths[:invoices], self)
    iir = InvoiceItemRepository.new
    @invoice_items = irr.from_csv(file_paths[:invoice_items], self)
    tr = TransactionRepository.new
    @transactions = tr.from_csv(file_paths[:transactions], self)
    cr = CustomerRepository.new
    @customers = cr.from_csv(file_paths[:customers], self)
  end

  def self.from_csv(file_paths)
    self.new(file_paths)
  end
  #need specific tests for merchant_id_search, merchant_to_item, get_invoices
  def get_merchant(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def get_items(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def get_invoices(id)
    invoices.find_all_by_merchant_id(id)
  end

  def get_items_from_invoice_id(invoice_id)
    item_ids = get_item_ids_from_invoice_id(invoice_id)
    ir = items.all
    item_ids.map do |item_id|
      ir.find_by_id(item_id)
    end
  end

  def get_item_ids_from_invoice_id(invoice_id)
    invoice_items = invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_items.map do |invoice_item|
      invoice_item.item_id
    end
  end

  def get_all_merchant_items
    merchants_and_items = {}
    merchants.all.map do |merchant|
      merchants_and_items[merchant] = items.find_all_by_merchant_id(merchant.id)
    end
    merchants_and_items
  end

  def get_all_merchant_prices
    get_all_merchant_items.transform_values do |item_array|
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

  def get_all_merchant_invoices
    merchants_and_invoices = {}
    merchants.all.map do |merchant|
      merchants_and_invoices[merchant] = get_invoices(merchant.id)
    end
    merchants_and_invoices
  end

  def search_ir_by_price(price)
    items.find_all_by_price(price)
  end

end
