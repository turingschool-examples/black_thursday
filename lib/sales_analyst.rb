# frozen_string_literal: true

# Sales Analyst performs various data operations.
class SalesAnalyst
# include Calculable
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    @engine.average_items_per_merchant.round(2)
  end

  def average_items_per_merchant_standard_deviation
    @engine.average_items_per_merchant_standard_deviation
  end

  def average_item_price_for_merchant(id)
    @engine.merchants.average_item_price_for_merchant(id)
  end

  # def average_average_price_per_merchant
  #   mr.all.map do |merchant|
  #     average_item_price_for_merchant(merchant.id)
  #   end.sum  / mr.all.length
  # end

end
