require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices

  def self.from_csv(sales_info)
    new(sales_info)
  end

  def initialize(sales_info)
    @items     = make_item_repo(sales_info)
    @merchants = make_merchant_repo(sales_info)
    @invoices  = make_invoice_repo(sales_info)
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

  def find_items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_by_id(id)
    merchants.find_by_id(id)
  end

  def find_invoices(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
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

end