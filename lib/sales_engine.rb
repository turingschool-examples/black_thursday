require_relative 'mathematics'

class SalesEngine
  include Math
  include Mathematics

  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers


  def initialize(csv_data)
    routes(csv_data)
  end


  def find_invoice_status_percentage(status)
    matched_status = @invoices.all.find_all do |invoice|
      invoice.status == status
    end
    percentage = ((matched_status.count.to_f / @invoices.all.count.to_f) * 100)
    percentage.round(2)
  end


  def top_day_of_the_week
    invoice_count = Hash.new(0)
    the_hash = @invoices.all.reduce(invoice_count) do |acc, invoice|
      if invoice_count == nil
        0
      else
        acc[invoice.created_at] += 1
      end
      acc
    end
    top_day = the_hash.select do |day, invoices_count|
      invoices_count == the_hash.values.max
    end
    top_day.keys
  end

  def find_bottom_merchants
    find_bottoms_merchants_by_invoice_count
  end

  def find_top_merchants
    find_top_merchants_by_invoice_count
  end

  def find_invoice_standard_deviation
    standard_deviation_for_merchant_invoices
  end

  def find_invoice_averages
    find_invoice_per_merchant_average
  end

  def find_invoices_by_merchant(merchant_id)
    @invoices.find_all_by_merchant_id(merchant_id)
  end

  def find_merchant_by_merchant_id(id)
    @merchants.find_by_id(id)
  end

  def find_items_by_id(id)
    items.find_all_by_merchant_id(id)
  end

  def routes(csv_data)
    csv_data.each_key do |key|
      case
      when key == :transactions
        make_transaction_repo(csv_data)
      when key == :invoices
        make_invoice_repo(csv_data)
      when key == :merchants
        make_merchant_repo(csv_data)
      when key == :items
        make_item_repo(csv_data)
      when key == :invoice_items
        make_invoice_items(csv_data)
      when key == :transactions
        make_transaction_repo(csv_data)
      when key == :customers
        make_customer_repo(csv_data)
      end
    end
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def self.from_csv(csv_data)
    SalesEngine.new(csv_data)
  end


  def make_invoice_items(csv_data)
    @invoice_items = InvoiceItemRepo.new(csv_data[:invoice_items], self)
  end

  def make_transaction_repo(csv_data)
    @transactions = TransactionRepo.new(csv_data[:transactions], self)
  end

  def make_invoice_repo(csv_data)
    @invoices = InvoiceRepo.new(csv_data[:invoices], self)
  end

  def make_merchant_repo(csv_data)
    @merchants = MerchantRepo.new(csv_data[:merchants], self)
  end

  def make_item_repo(csv_data)
    @items = ItemRepo.new(csv_data[:items], self)
  end

  def make_transaction_repo(csv_data)
    @transactions = TransactionRepo.new(csv_data[:transactions], self)
  end

  def make_customer_repo(csv_data)
    @customers = CustomerRepo.new(csv_data[:customers], self)
  end
end
