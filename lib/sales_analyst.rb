require "merchant_repo"
require "item_repo"
require "invoice_repo"
require "customer_repo"
require "transaction_repo"
require "invoice_item_repo"
require "bigdecimal"
require "pry"

class SalesAnalyst
  attr_reader :itemrepository,
    :merchantrepository,
    :invoicerepository,
    :customerrepository,
    :transactionrepository,
    :invoiceitemrepository,
    :items,
    :merchants,
    :invoices,
    :customers,
    :transactions,
    :invoiceitems

  def initialize(items_repo,
    merchants_repo,
    invoices_repo,
    customers_repo,
    transactions_repo,
    invoice_items_repo)
    @itemrepository = items_repo
    @merchantrepository = merchants_repo
    @invoicerepository = invoices_repo
    @customerrepository = customers_repo
    @transactionrepository = transactions_repo
    @invoiceitemrepository = invoice_items_repo
    @items = @itemrepository.all
    @merchants = @merchantrepository.all
    @invoices = @invoicerepository.all
    @customers = @customerrepository.all
    @transactions = @transactionrepository.all
    @invoiceitems = @invoiceitemrepository.all
  end

  def average_items_per_merchant
    (@items.count.to_f / @merchants.count.to_f).round(2)
  end

  def total_items_per_merchant
    results = []
    @merchants.each do |merchant|
      item_count = @items.count do |item|
        item.item_attributes[:merchant_id] == merchant.merchant_attributes[:id]
      end
      results << item_count
    end
    results
  end

  def standard_deviation(mean, variance)
    result = variance.sum { |object| (object - mean)**2 }
    Math.sqrt(result.to_f / (variance.count - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(average_items_per_merchant, total_items_per_merchant)
  end
  
  def merchants_with_high_item_count
    stdev = average_items_per_merchant_standard_deviation
    high_items = total_items_per_merchant.find_all {|total| total > stdev + average_items_per_merchant}
    return high_items.count
  end

end
