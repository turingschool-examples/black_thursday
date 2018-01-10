require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine

  def initialize(data)
    @items         = ItemRepository.new(data[:items], self)
    @merchants     = MerchantRepository.new(data[:merchants], self)
    @invoices      = InvoiceRepository.new(data[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(data[:invoice_items], self)
    @transactions  = TransactionRepository.new(data[:transactions], self)
    @customers     = CustomerRepository.new(data[:customers], self)
    @sales_analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def items
    @items
  end

  def all_items
    @items.all
  end

  def merchants
    @merchants
  end

  def all_merchants
    @merchants.all
  end

  def invoices
    @invoices
  end

  def all_invoices
    @invoices.all
  end

  def transactions
    @transactions
  end

  def customers
    @customers
  end

  def invoice_items
    @invoice_items
  end

  def assign_item_count(id, num)
    @merchants.assign_item_count(id, num)
  end

  def assign_total_revenue(id, num)
    @merchants.assign_total_revenue(id, num)
  end

  def find_merchant_by_id(id)
    @merchants.find_by_id(id)
  end

  def items_by_id(id)
    @items.find_all_by_merchant_id(id)
  end

  def items_by_invoice_id(id)
    @items.items_by_invoice_id(id)
  end

  def find_invoice_by_merchant_id(id)
    @invoices.find_all_by_merchant_id(id)
  end

  def find_items_by_invoice_id(id)
    item_ids = @invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      invoice_item.item_id
    end

    item_ids.map do |item_id|
      @items.find_by_id(item_id)
    end
  end

  def find_cost_by_invoice_id(id)
    @invoice_items.find_all_by_invoice_id(id)
  end

  def find_transactions_by_invoice_id(id)
    @transactions.find_all_by_invoice_id(id)
  end

  def find_customer_by_customer_id(id)
    @customers.find_by_id(id)
  end

  def find_invoice_by_invoice_id(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def find_all_customers_by_merchant_id(id)
    @merchants.find_invoice_by_merchant_id(id)
  end

  def find_all_merchants_by_customer_id(id)
    @invoices.find_all_by_customer_id(id)
  end

  def find_invoices_by_date(date)
    @invoices.find_all_by_date(date)
  end

  def find_pending_invoices
    @invoices.find_pending_invoices
  end

  def find_item_by_id(id)
    @items.find_by_id(id)
  end
end
