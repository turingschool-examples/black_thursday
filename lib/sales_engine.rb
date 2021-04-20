require 'CSV'
require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'sales_analyst'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'

class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(paths)
   @items = ItemRepo.new(paths[:items], self)
   @merchants = MerchantRepo.new(paths[:merchants], self)
   @analyst = SalesAnalyst.new(self)
   @invoices = InvoiceRepo.new(paths[:invoices], self)
   @invoice_items = InvoiceItemRepo.new(paths[:invoice_items], self)
   @transactions = TransactionRepo.new(paths[:transactions], self)
   @customers = CustomerRepo.new(paths[:customers], self)
  end

  def self.from_csv(paths)
    new(paths)
  end

  def all_items
    @items.all
  end

  def all_merchants
    @merchants.all
  end

  def all_invoices
    @invoices.all
  end

  def item_count
    count = @items.all.length
    count.to_f
  end

  def merchant_count
    count = @merchants.all.length
    count.to_f
  end

  def invoice_count
    count = @invoices.all.length
    count.to_f
  end

  def average_price
    @items.average_price
  end

  def item_count_per_merchant
    @items.item_count_per_merchant
  end

  def invoice_count_per_merchant
    @invoices.invoice_count_per_merchant
  end

  def invoice_count_per_day
    @invoices.invoice_count_per_day
  end

  def find_all_by_merchant_id(id)
    @items.find_all_by_merchant_id(id)
  end

  def find_by_id(id)
    @merchants.find_by_id(id)
  end

  def find_all_by_status(status)
    @invoices.find_all_by_status(status)
  end

  def find_all_by_result(result)
    @transactions.find_all_by_result(result)
  end

  def find_by_invoice_id(id)
    @transactions.find_by_id(id)
  end

  def find_all_by_invoice_id(id)
    @invoice_items.find_all_by_invoice_id(id)
  end
end
