require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'sales_analyst'
require 'csv'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers
  def initialize(path)
    @items = ItemRepository.new(path[:items])
    @merchants = MerchantRepository.new(path[:merchants])
    @invoices = InvoiceRepository.new(path[:invoices])
    @invoice_items = InvoiceItemRepository.new(path[:invoice_items])
    @transactions = TransactionRepository.new(path[:transactions])
    @customers = CustomerRepository.new(path[:customers])
  end

  def self.from_csv(path)
    new(path)
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def merchant_repo_find_by_id(id)
      @merchants.find_by_id(id)
  end

  def invoice_repo_group_by_merchant
    @invoices.group_invoices_by_merchant
  end

  def invoice_repo_invoices_per_merchant
    @invoices.invoices_per_merchant
  end

  def invoice_repo_total_merchants
    @invoices.number_of_merchants
  end

  def invoice_repo_total_invoices
    @invoices.total_invoices
  end

  def invoice_repo_invoices_per_day
    @invoices.invoices_per_day
  end

  def invoice_repo_invoices_day_created_date
    @invoices.invoices_by_created_date      
  end

  def invoice_repo_by_status(status)
    @invoices.invoice_status_total(status)
  end

end
