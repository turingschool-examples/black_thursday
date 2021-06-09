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

  def revenue_by_date(date)
    total_revenue_by_date = {}
    @invoices.find_invoice_by_date(date).each do |invoice|
      if transaction_repo_invoice_paid_in_full(invoice.id) == true
        total_revenue_by_date[date] = invoice_items_repo_invoice_total_by_id(invoice.id)
      end
    end
    total_revenue_by_date
  end

  def total_unit_price_by_merchant_id
    merchant_id_to_invoice_total = Hash.new{|h,k| h[k] = Array.new}
    @invoices.invoice_id_by_merchant_id.each do |merchant_id, invoice_ids|
      invoice_ids.each do |invoice_id|
        if transaction_repo_invoice_paid_in_full(invoice_id) == true
          merchant_id_to_invoice_total[merchant_id] << invoice_items_repo_invoice_total_by_id(invoice_id)
        end
      end
    end
    merchant_id_to_invoice_total
  end

  def price_by_merchant
    merchant_to_price = {}
    total_unit_price_by_merchant_id.each do |merchant_id1, prices|
      @merchants.merchant_instance_by_id.each do |merchant_id2, merchant|
        if merchant_id1 == merchant_id2
          merchant_to_price[merchant] = prices.sum
        end
      end
    end
    merchant_to_price
  end

  def item_repo_find_by_id(id)
    @items.find_by_id(id)
  end

  def item_repo_group_items_by_merchant
    @items.group_items_by_merchant
  end

  def item_repo_items_per_merchant
    @items.items_per_merchant
  end

  def item_repo_total_merchants
    @items.number_of_merchants
  end

  def item_repo_total_items
    @items.total_items
  end

  def item_repo_total_items_by_merchant(merchant_id)
    @items.total_items_by_merchant(merchant_id)
  end

  def item_repo_merchant_price_sum(merchant_id)
    @items.merchant_price_sum(merchant_id)
  end

  def item_repo_total_item_price
    @items.items_total_price
  end

  def item_repo_all_items_by_price
    @items.all_items_by_price
  end

  def item_repo_all_items
    @items.all
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

  def transaction_repo_invoice_paid_in_full(invoice_id)
    @transactions.invoice_paid_in_full(invoice_id)
  end

  def invoice_items_repo_invoice_total_by_id(invoice_id)
    @invoice_items.invoice_total_by_id(invoice_id)
  end

  def group_items_by_merchant_instance
    merchant_instance_to_items = {}
    @items.group_items_by_merchant.each do |merchant_id, items|
      @merchants.all.each do |merchant|
        if merchant.id == merchant_id
          merchant_instance_to_items[merchant] = items
        end
      end
    end
    merchant_instance_to_items
  end

  def invoice_items_by_merchant_id(merchant_id)
    @invoices.find_all_by_ids_by_merchant_id(merchant_id).flat_map do |invoice_id|
      @invoice_items.find_all_by_invoice_id(invoice_id)
    end
  end

end
