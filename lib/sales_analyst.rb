# SalesAnalyst
require_relative 'sales_engine'
class SalesAnalyst

  attr_reader :merchant_repo,
              :item_repo

  def initialize(sales_engine)
    @merchant_repo = sales_engine.merchants
    @item_repo = sales_engine.items
  end

  def average_items_per_merchant
    (item_repo.items.length.to_f / merchant_repo.merchants.length).round(2)
  end
  
end
