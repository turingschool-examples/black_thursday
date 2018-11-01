require_relative './statistics'
require_relative './merchant_analyst'
require_relative './invoice_analyst'
require_relative './item_analyst'

class SalesAnalyst
  include Statistics
  include MerchantAnalyst
  include InvoiceAnalyst
  include ItemAnalyst

  def initialize(input)
    @merchants = input[:merchants]
    @items = input[:items]
    @invoices = input[:invoices]
    @transactions = input[:transactions]
    @invoice_items = input[:invoice_items]
    @customers = input[:customers]
  end

  def item_count_by_merchant
    items_by_merchant.map { |items| [items[0], items[1].count] }
  end

  def items_by_merchant
    @items.all.group_by { |item| item.merchant_id }
  end

  def average_item_price_for_merchant(merchant_id)
    sum_by_merchant = items_by_merchant.map do |items|
      [items[0], sum(items[1].map { |also_item| also_item.unit_price }) /items[1].count]
    end
    found_merchant = sum_by_merchant.find do |index_0, index_1|
       index_0 == merchant_id
    end
    found_merchant[1].round(2)
  end

  def total_price_per_day(date)
    by_date = @invoice_item.find_all do |item|
      item.created_at == date
    end
    tot_of_all_prices = by_date.all.inject(0) do |sum, item|
      sum + item.unit_price_to_dollars
    end
    tot_of_all_prices
  end

  def total_revenue_by_date(date)
    string_date = date.strftime("%Y-%m-%d")
    valid_invoices = invoice_from_date(string_date).select do |invoice|
      @transactions.all.any? do |trans|
        trans.invoice_id == invoice.id &&
        trans.result == :success
      end
    end
    items_from_invoice = valid_invoices.map do |invoice|
        @invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
    items_from_invoice.inject(0) do |sum, item_invoice|
      sum + item_invoice.quantity * item_invoice.unit_price
    end.round(2)
  end

  def invoice_from_date(string_date)
    @invoices.all.find_all do |invoice|
      invoice.created_at.strftime("%Y-%m-%d") == string_date
    end
  end

  def min_one_transaction_passed(invoice)
    invoice_transactions = @transactions.all.select do |transaction|
      transaction.invoice_id == invoice.id
    end
    invoice_transactions.any? { |transaction| transaction.result == :success }
  end

  def one_time_buyers
    customer_and_invoices = @invoices.all.group_by do |invoice|
      invoice.customer_id
    end
    otb = customer_and_invoices.select do |customer, invoices|
      invoices.length == 1
    end
    otb.map do |customer, invoice|
      @customers.find_by_id(invoice.first.customer_id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_in_month = @merchants.all.find_all do |merchant|
      month == merchant.created_at.strftime("%B")
    end
    merchants_in_month.find_all do |merchant|
       @items.find_all_by_merchant_id(merchant.id).length == 1
    end
  end

end
