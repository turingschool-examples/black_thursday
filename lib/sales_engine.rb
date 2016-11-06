require_relative './merchant_repo'
require_relative './item_repo'
require_relative './invoice_repo'
require_relative './invoice_item_repo'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items

  def initialize(file_path)
    @merchants     = MerchantRepo.new(file_path[:merchants], self)
    @items         = ItemRepo.new(file_path[:items], self)
    @invoices      = InvoiceRepo.new(file_path[:invoices], self)
    @invoice_items = InvoiceItemRepo.new(file_path[:invoice_items], self)
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

  def find_invoice_items_by_merchant_id(merchant_id)
    @invoice_items.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_invoice_id(invoice_id)
    @merchants.find_by_id(invoice_id)
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

  def all_invoice_items
    @invoice_items.all.count
  end
end
