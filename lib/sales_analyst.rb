require_relative 'merchant_repo'
require_relative 'item_repo'
require 'time'
require 'bigdecimal'
require 'pry'


class SalesAnalyst

  attr_reader :merchants, :items

  def initialize(merchant_repo, item_repo)
    @merchants = merchant_repo
    @items = item_repo
  end

  def average_items_per_merchant
    total_items = @items.all.count.to_f
    total_merchants = @merchants.all.count.to_f
    (total_items / total_merchants)
  end
end
