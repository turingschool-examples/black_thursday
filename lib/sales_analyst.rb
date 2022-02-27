require_relative 'merchant_repository'
require_relative 'sales_engine'
require_relative 'item_repository'
require 'pry'

class SalesAnalyst

  def initialize(merchants, items)
    @merchants = merchants
    @items = items
  end


  def average_items_per_merchant
    item_num = []
    @merchants.all.each do |merchant|
      item_num << @items.find_all_by_merchant_id(merchant.id).length
    end
    (item_num.sum(0.0)/item_num.size).round(2)
  end
end


  
