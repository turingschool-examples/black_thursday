require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine

  def self.from_csv(data)
    @items         = ItemRepository.new(data[:items], self)
    @merchants     = MerchantRepository.new(data[:merchants], self)
    @invoices      = InvoiceRepository.new(data[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(data[:invoice_items], self)
    @transactions  = TransactionRepository.new(data[:transactions], self)
    @customers     = CustomerRepository.new(data[:customers], self)
    @sales_analyst = SalesAnalyst.new(self)
    self
  end

  def self.items
    @items
  end

  def self.all_items
    @items.all
  end

  def self.merchants
    @merchants
  end

  def self.all_merchants
    @merchants.all
  end

  def self.invoices
    @invoices
  end

  def self.all_invoices
    @invoices.all
  end

  def self.assign_item_count(id, num)
    @merchants.assign_item_count(id, num)
  end

  def self.find_merchant_by_id(id)
    @merchants.find_by_id(id)
  end

  def self.items_by_id(id)
    @items.find_all_by_merchant_id(id)
  end

  def self.find_invoice_by_merchant_id(id)
    @invoices.find_all_by_merchant_id(id)
  end

  def self.find_items_by_invoice_id(id)
    @invoice_items.find_all_by_invoice_id(id)
  end
end
