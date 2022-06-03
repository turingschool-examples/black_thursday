require 'bigdecimal'
require 'pry'
require './lib/item_repository'
class SalesAnalyst
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository

  def initialize(item_repository, merchant_repository, invoice_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
    @invoice_repository = invoice_repository
  end

  def average_items_per_merchant
   (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end
  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    sum = items_per_merchant.sum(0.0) {|item| (item - mean) ** 2}
    variance = sum / (items_per_merchant.size - 1)
    require 'pry';binding.pry
    standard_deviation = Math.sqrt(variance)
  end
  def items_per_merchant
    items_per_merchant =[]

    @merchant_repository.all.each do |merchant|
      item_count = @item_repository.find_all_by_merchant_id(merchant.id).count
      items_per_merchant << item_count
    end
    items_per_merchant
  end
end
