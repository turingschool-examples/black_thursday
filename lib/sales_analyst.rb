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
    first = items_per_merchant.map do |num|
      ((num - average_items_per_merchant)**2).to_f
      # require'pry';binding.pry
    end.sum
    second = ((first) / (merchant_id_array.length - 1))
    third = ((second)**0.5).to_f
    third.round(2)
  end
end
