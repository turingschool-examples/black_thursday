require 'CSV'
require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants,
              :analyst
  def initialize(paths)
    @items = ItemRepo.new(paths[:items], self)
    @merchants = MerchantRepo.new(paths[:merchants], self)
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(paths)
    new(paths)
  end
  # self.from_csv(hash from i0 directions) => paths
  # from csv method will call initialize to pass
  # the hash through, should return the instance of itself
  def all_items
    @items.all
  end

  def all_merchants
    @merchants.all
  end

  def item_count
    count = @items.all.length
    count.to_f
  end

  def merchant_count
    count = @merchants.all.length
    count.to_f
  end

  def average_item_price
    @items.average_price
  end

  def item_count_per_merchant
    @items.item_count_per_merchant
  end

  def find_merchant_id(id)
    @items.find_all_by_merchant_id(id)
  end
end
