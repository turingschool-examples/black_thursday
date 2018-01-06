require_relative "item_repository"
require_relative "merchant_repository"
require "bigdecimal"
require 'pry'

class SalesEngine

  attr_reader :merchants,
              :items

  def initialize(file_paths)
    @merchants = MerchantRepository.new(file_paths[:merchants], self)
    @items     = ItemRepository.new(file_paths[:items], self)
  end

  def self.from_csv(file_paths)
    self.new(file_paths)
  end

  def merchant_id_search(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def from_merchant_to_item(id)
    items.find_all_by_merchant_id(id)
  end

  def get_all_merchant_items
    merchants_and_items = {}
    merchants.all.map do |merchant|
      merchants_and_items[merchant] = items.find_all_by_merchant_id(merchant.id)
    end
    merchants_and_items
  end

  def get_all_merchant_prices
    get_all_merchant_items.transform_values do |item_array|
      item_array.map do |item|
        item.unit_price
      end
    end
  end

  def get_one_merchant_prices(merchant_id)
    get_all_merchant_prices.find do |merchant, prices|
      merchant.id == merchant_id
    end.last.flatten
  end

  def search_ir_by_price(price)
    items.find_all_by_price(price)
  end

end
