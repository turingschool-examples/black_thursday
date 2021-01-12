require_relative './merchant_repo'
require_relative './item_repo'
require_relative './invoice_repo'
require_relative './sales_analyst'
require_relative './invoice_item_repo'
require_relative './customer_repo'
require_relative './transaction_repo'


class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :sales_analyst,
              :invoice_items,
              :customers,
              :transactions

  def initialize(data)
    process_data(data)
  end

  def self.from_csv(data)
    new(data)
  end

  def process_data(data)
    data.each do |key, value|
      if key == :merchants
        @merchants = MerchantRepository.new(data[:merchants], self)
      elsif key == :items
        @items = ItemRepository.new(data[:items], self)
      elsif key == :invoices
        @invoices = InvoiceRepository.new(data[:invoices], self)
      elsif key == :invoice_items
        @invoice_items = InvoiceItemRepository.new(data[:invoice_items])
      elsif key == :customers
        @customers = CustomerRepository.new(data[:customers], self)
      elsif key == :transactions
        @transactions = TransactionRepository.new(data[:transactions], self)
      end
    end
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def merchant_items(merchant_id)
    @items.find_by_merchant_id(merchant_id)
  end

  def merchant_invoices(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def all_merchant_invoices
    @merchants.all.map do |merchant|
      merchant_invoices(merchant.id).length
    end
  end

  def numerator_invoices_per_merchant
    numerator = 0
    all_merchant_invoices.each do |merchant_invoice_count|
      numerator = numerator + merchant_invoice_count
    end
    numerator
  end

  def invoice_status_count(status)
    @invoices.all.count do |invoice|
      invoice.status == status
    end
  end

  def invoices_per_day_count
    invoice_count = {}
    @invoices.invoices_per_weekday.map do |weekday, invoices|
      invoice_count[weekday] = invoices.count
    end
    invoice_count
  end

  def pending_invoices
    @invoices.all.select do |invoice|
      @transactions.find_all_by_invoice_id(invoice.id).none? do |transaction|
        transaction.result == :success
      end
    end
  end

  def merchants_with_pending_invoices
    pending_invoices.map do |pending_invoice|
      @merchants.find_by_id(pending_invoice.merchant_id)
    end.uniq
  end

  def successful_invoices
    @invoices.all.select do |invoice|
      @transactions.find_all_by_invoice_id(invoice.id).any? do |transaction|
        transaction.result == :success
      end
    end
  end

  def successful_invoice_ids
    successful_invoices.map do |invoice|
      invoice.id
    end.uniq
  end

  def invoice_item_sucessful_transactions
    successful_invoice_ids.map do |invoice_id|
      @invoice_items.find_all_by_invoice_id(invoice_id)
    end.flatten
  end

  def total_revenue_by_day(date)
    revenue = BigDecimal.new(0)
    # require 'pry'; binding.pry
    successful_invoice_items_by_day(date).each do |ii|
      revenue += ii.unit_price
    end
    revenue
  end

  def successful_invoice_items_by_day(date)
    invoice_item_sucessful_transactions.select do |ii|
      (date_to_day(ii.created_at)) == date
    end
  end

  def date_to_day(date)
    date.strftime('%Y-%m-%d')
  end
end

  # def successful_invoice_item_by_day(day)
  #   invoice_item_sucessful_transactions.select do |ii|
  #     # require 'pry'; binding.pry
  #     ii.created_day == day
  #   end
  # end
# end
