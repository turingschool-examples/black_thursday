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
    sum = items_per_merchant.values.sum(0.0) {|item| (item - mean) ** 2}
    variance = (sum / (items_per_merchant.size - 1)).to_f
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    high_count =[]
    @merchant_repository.all.each do |merchant|
      item_count = @item_repository.find_all_by_merchant_id(merchant.id).count
      if item_count > (average_items_per_merchant +  average_items_per_merchant_standard_deviation)
        high_count << merchant
      end
    end
    high_count
  end

  def items_per_merchant
    merchant_items = Hash.new
    item_count = 0
    @merchant_repository.all.each do |merchant|
      item_count = @item_repository.find_all_by_merchant_id(merchant.id).size
      merchant_items[merchant.id] = item_count
    end
    merchant_items
  end
  def average_item_price_for_merchant(id)
    merchant_items = @item_repository.find_all_by_merchant_id(id)
    price_sum = merchant_items.sum(0.0) {|item| item.unit_price}
    (price_sum / merchant_items.count).round(0)
  end
  def average_average_price_per_merchant
    merchant_averages =[]
    @merchant_repository.all.each do |merchant|
      merchant_averages << average_item_price_for_merchant(merchant.id)
    end
    binding.pry
    merchant_averages.sum(0.0) / merchant_averages.count
  end
end
