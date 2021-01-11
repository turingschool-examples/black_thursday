require 'csv'
require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'
class SalesEngine
  attr_reader :merchants,
              :items,
              :analyst
  def initialize(locations)
    @merchants = MerchantRepository.new(locations[:merchants], self)
    @items = ItemRepository.new(locations[:items], self)
    @analyst = SalesAnalyst.new(self)
  end
  def self.from_csv(locations)
    SalesEngine.new(locations)
  end
  def find_by_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end
  def pass_item_array
    @items.all
  end
  def merchant_id_list
    @items.merchant_id_list
  end
  def merchant_hash_item_count
    @items.merchant_item_count
  end
  def average_item_price
    @items.average_item_price
  end
  def count_items
    @items.all.length
  end
  def count_merchants
    @merchants.all.length
  end
  def pass_item_sum
    @items.items_sum
  end
  def find_all_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end
end
