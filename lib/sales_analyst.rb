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

  def items
    # merchant_repo.merchants.map do |merchant|
      item_repo.find_all_by_merchant_id(12335971).count
  end

  def average_items_per_merchant_standard_deviation

  end

end
