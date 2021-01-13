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

  def total_revenue_by_date(day)
    revenue = BigDecimal.new(0)
    successful_invoice_transactions(day).each do |invoice|
      @invoice_items.find_all_by_invoice_id(invoice.id).each do |ii|
        revenue += (ii.unit_price * ii.quantity)
      end
    end
    revenue
  end

  def successful_invoice_transactions(day)
    invoices_by_date(day).select do |invoice|
      @transactions.successful_transactions_invoice_ids.any? do |trans_inv_id|
        trans_inv_id == invoice.id
      end
    end
  end

  def invoices_by_date(day)
    @invoices.all.select do |invoice|
      invoice.created_at == day
    end
  end
end
