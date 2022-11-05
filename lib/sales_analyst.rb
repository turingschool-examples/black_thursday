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

  def merchants_with_high_item_count
    @engine.merchants.merchants_with_high_item_count
  end

    #average = average_items_per_merchant
    # @engine.items_per_merchant.map { |number| (number - average)**2 }.sum / @engine.merchants.all.length

  # def average_item_price_for_merchant(id)
  #   #@engine.items_per_merchant
  #   @engine.items.find_all_by_merchant_id(merchant_id)
  #   # all_items.sum.fdiv(all_items.length)
  # end

  # def average_average_price_per_merchant
  #   mr.all.map do |merchant|
  #     average_item_price_for_merchant(merchant.id)
  #   end.sum  / mr.all.length
  # end
end
