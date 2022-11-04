# frozen_string_literal: true

# Sales Analyst performs various data operations.
class SalesAnalyst
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    @engine.average_items_per_merchant
  end

  # def average_items_per_merchant_standard_deviation(item_repo, merch_repo)
  #   number_of_items_per_merchant = merch_repo.all.map do |merchant|
  #     find_all_by_merchant_id(merchant.id).length
  #   end
  #   average = average_items_per_merchant(item_repo, merch_repo)
  #   number_of_items_per_merchant.map { |number| (number - average)**2 }.sum / merch_repo.all.length
  # end

  # def average_item_price_for_merchant(item_repo, merchant_id)
  #   all_items = item_repo.find_all_by_merchant_id(merchant_id)
  #   all_items.sum.fdiv(all_items.length)
  # end

  # def average_average_price_per_merchant
  #   mr.all.map do |merchant|
  #     average_item_price_for_merchant(merchant.id)
  #   end.sum  / mr.all.length
  # end

end
