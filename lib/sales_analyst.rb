require "merchant_repo"
require "item_repo"
require "bigdecimal"
require 'pry'

class SalesAnalyst
  attr_reader :itemrepository, :merchantrepository, :invoicerepository, :customerrepository, :items, :merchants, :invoices, :customers

  def initialize(items_repo, merchants_repo, invoices_repo, customers_repo)
    @itemrepository = items_repo
    @merchantrepository = merchants_repo
    @invoicerepository = invoices_repo
    @customerrepository = customers_repo
    @items = @itemrepository.all
    @merchants = @merchantrepository.all
    @invoices = @invoicerepository.all
    @customers = @customerrepository.all
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
    result = variance.sum {|object| (object - mean) **2}
    Math.sqrt(result.to_f / (variance.count - 1)).round(2)
  end


  def average_items_per_merchant_standard_deviation

    standard_deviation(average_items_per_merchant, total_items_per_merchant)

  end
end
