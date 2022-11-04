require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (sales_engine.items.all.count / sales_engine.merchants.all.count.to_f).round(2)
    # find_all_by_merchant_id(merchant_id)
    # require 'pry'; binding.pry
    # test = sales_engine.items.all.map do |item|
    #     sales_engine.items.find_all_by_merchant_id(item.merchant_id).length
    # end
    # require 'pry'; binding.pry
  end

  def average_items_per_merchant_standard_deviation; end
end
