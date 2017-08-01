require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

require 'csv'
require 'pry'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers
  def initialize(data)
    @items          = ItemRepository.new(data[:items], self)
    @merchants      = MerchantRepository.new(data[:merchants], self)
    @invoices       = InvoiceRepository.new(data[:invoices], self)
    @invoice_items  = InvoiceItemRepository.new(data[:invoice_items], self)
    @transactions   = TransactionRepository.new(data[:transactions], self)
    @customers      = CustomerRepository.new(data[:customers], self)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def fetch_items(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def fetch_merchant(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def fetch_invoices(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def fetch_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end

  def fetch_invoice_id_for_items(id)
    result = []
    @invoice_items.find_all_by_invoice_id(id).each do |invoice_item|
       result << @items.find_by_id(invoice_item.item_id)
     end
     result
  end

  def fetch_invoice_id_for_transactions(id)
    @transactions.find_all_by_invoice_id(id)
  end

  def fetch_invoice_id_for_customers(id)
    @customers.find_by_id(id)
  end

  def fetch_invoice_id_from_transactions(id)
    @invoices.find_by_id(id)
  end

  def fetch_customers_by_merchant_id(id)
    result = []
    merchant_invoices = @invoices.find_all_by_merchant_id(id)
    merchant_invoices.each do |invoice|
      result << @customers.find_by_id(invoice.customer_id)
    end
    result.uniq
  end

  def fetch_merchant_by_customer_id(id)
    @invoices.find_all_by_customer_id(id)
  end

  def fetch_invoice_id_for_invoice_items(id)
    total = 0
    items = @invoice_items.find_all_by_invoice_id(id)
    items.each do |item|
      total += item.quantity * item.unit_price
    end
    total
  end

  def top_revenue_earners(x)
    paid_invoices = @invoices.all.group_by { |invoice| invoice.is_paid_in_full? }
    merchant_invoices = paid_invoices[true].group_by { |invoice| invoice.merchant_id }
    merchant_invoices.each_value do |invoices|
      invoices.map! { |invoice| invoice.total }
    end
    total_revenue = merchant_invoices.keys.sort_by do |merchant_id|
      merchant_invoices[merchant_id].reduce(:+)
    end
    total_revenue.reverse[0...x]
  end


end
