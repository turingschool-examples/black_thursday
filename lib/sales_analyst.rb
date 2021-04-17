require_relative './sales_engine'
require_relative './items'
require_relative './merchants'
require_relative './items_repo'
require_relative './merchants_repo'
require 'csv'

class SalesAnalyst
  attr_reader :items_repo,
              :merchants_repo

  def initialize(items_repo, merchants_repo)
    @items_repo     = items_repo
    @merchants_repo = merchants_repo
  end

  def all_items
    @items_repo.all
  end

  def all_merchants
    @merchants_repo.all
  end

  def average_items_per_merchant
    total = (all_items.count / all_merchants.count.to_f).round(2)
  end

  def merchant_id_array
    all_merchants.map do |merchant|
      merchant.id
    end
  end

  def items_per_merchant
    merchant_id_array.map do |id|
      @items_repo.find_all_by_merchant_id(id).length
    end
  end

  def average_items_per_merchant_standard_deviation
    squared_differences = items_per_merchant.map do |num|
      ((num - average_items_per_merchant)**2).to_f
    end.sum
    divided_sum = ((squared_differences) / (merchant_id_array.length - 1))
    square_root = ((divided_sum)**0.5).to_f
    square_root.round(2)
  end
  def z_score(value)
    ((value - average_items_per_merchant) / average_items_per_merchant_standard_deviation).to_f
  end

  def merchants_num_items_hash
    merchant_hash = {}
    all_merchants.each do |merchant|
      items_per_merchant.each do |num|
        merchant_hash[merchant] = num
      end
    end
    merchant_hash
  end

  def merchants_with_high_item_count
    merchants_with_high_item_count = []
    merchants_num_items_hash.each do |merchant, num|
      # require'pry';binding.pry
      if z_score(num) >= 1.0 || z_score(num) <= -1.0
        merchants_with_high_item_count << merchant
      end
    end
    merchants_with_high_item_count
  end
end
