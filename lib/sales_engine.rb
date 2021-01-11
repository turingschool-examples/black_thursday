require_relative 'mathematics'

class SalesEngine
  include Math
  include Mathematics

  attr_reader :merchants,
              :items,
              :invoices,
              :transactions

  def initialize(csv_data)
    routes(csv_data)
  end

  def top_day_of_the_week
    # invoice_hash = @invoices.all.group_by do |invoice|
    #   invoice.created_at
    # end.flatten
    # invoice_hash
    # require "pry"; binding.pry

    created_at_array = []
    popular_days = []

    @invoices.all.each do |invoice|
        created_at_array << invoice.created_at
    end

    this_is_the_most_popular_day =  created_at_array.max_by{|day|created_at_array.count(day)}

        popular_days << this_is_the_most_popular_day
        # created_at_array.delete(this_is_the_most_popular_day)

  require "pry"; binding.pry
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
      end
    end
  end

  def analyst
    SalesAnalyst.new(self)
  end

  def self.from_csv(csv_data)
    SalesEngine.new(csv_data)
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
end
