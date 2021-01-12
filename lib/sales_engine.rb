require 'csv'
require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :analyst
  def initialize(locations)
    @merchants = MerchantRepository.new(locations[:merchants], self)
    @items = ItemRepository.new(locations[:items], self)
    @invoices = InvoiceRepository.new(locations[:invoices], self)
    @analyst = SalesAnalyst.new(self)
  end
  def self.from_csv(locations)
    SalesEngine.new(locations)
  end
  def find_by_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end
  def pass_item_array
    @items.all
  end
  def merchant_id_list
    @items.merchant_id_list
  end
  def merchant_hash_item_count
    @items.merchant_item_count
  end
  def average_item_price
    @items.average_item_price
  end
  def count_items
    @items.all.length
  end
  def count_merchants
    @merchants.all.length
  end
  def pass_item_sum
    @items.items_sum
  end
  def find_all_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def total_invoices
    @invoices.all.length
  end

  def per_merchant_invoice_count_hash
    @invoices.per_merchant_invoice_count
  end

  def invoices_per_day
    @invoices.invoices_per_day
  end

  def invoices_per_status
    @invoices.invoices_per_status
  end
end
