require_relative './sales_engine'
require_relative './items'
require_relative './merchants'
require_relative './items_repo'
require_relative './merchants_repo'
require 'csv'

class SalesAnalyst < SalesEngine
  attr_reader :items,
              :merchants

  def initialize(items, merchants)
    @items     = items
    @merchants = merchants
  end

  def average_items_per_merchant
    merchant_ids = @items.map do |item|
      item.merchant_id
    end
    merchant_ids.each do |merchant_id|
      @items.map do |item|
        item.find_all_by_merchant_id(merchant_id)
      end
    end
  end
end
