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

  def invoice_items_by_date(date)
    ii_price_by_date = Hash.new{|hash, key| hash[key] = Array.new}
    @invoice_items.find_unit_price_by_date(date).each do |invoice_item|
      ii_price_by_date[date] << invoice_item.unit_price
    end
    ii_price_by_date
  end

  def total_unit_price_by_merchant_id
    merchant_id_to_unit_price = Hash.new
    @invoice_items.total_unit_price_by_invoice_id.each do |invoice_id1, unit_price|
      @invoices.invoice_id_by_merchant_id.each do |merchant_id, invoice_ids|
        invoice_ids.each do |invoice_id2|
          if invoice_id2 == invoice_id1
          merchant_id_to_unit_price[merchant_id] = unit_price
          end
        end
      end
    end
    merchant_id_to_unit_price
  end
end
