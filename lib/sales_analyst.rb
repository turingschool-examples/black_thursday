require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require 'pry'
require 'CSV'

class SalesAnalyst



  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end

  def average_items_per_merchant
    merchant_ids = @items.items.map {|item| item.merchant_id}
    merchant_items = Hash.new(0)
    merchant_ids.each do |id|
      merchant_items[id] += 1
    end
  
    ((merchant_items.values.sum).to_f / merchant_items.keys.count).round(2)

  end
end
