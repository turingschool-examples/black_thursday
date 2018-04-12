class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
    # binding.pry
  end

  def merchants
    @engine.merchants.all
  end

  def items
    @engine.items.all
  end

  def average_items_per_merchant
    (total_number_of_items_per_merchant.reduce(:+) / total_merchants.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    @result ||= total_number_of_items_per_merchant.map do |items|
      (items - average_items_per_merchant) ** 2
    end
    calculated = @result.reduce(:+).to_f / (total_number_of_items_per_merchant.length - 1)
    Math.sqrt(calculated).round(2)
  end

  # this method returns an array of all merchants whose
  # total item count - average items per all merchants
  # is greater than one standard deviation
  # iterate over merchant objects, for each object subtract
  # average items per all merchants from total items per merchant
  # in the loop. return the merchant object in the array if
  # the difference is greater than one standard deviation

  def merchants_with_high_item_count
    merchants.map do |merchant|
      difference = merchant.items.length - average_items_per_merchant
      merchant if difference > average_items_per_merchant_standard_deviation
    end.compact
  end

  def average_item_price_for_merchant(id)
    found ||= @engine.items.find_all_by_merchant_id(id)
    to_average = found.map do |item|
      item.unit_price
    end.reduce(:+) / found.length
    to_average.round(2)
  end

  def average_average_price_per_merchant
    summed = sum_of_average_item_price_for_each_merchant
    (summed / total_merchants).round(2)
  end

  private

  def sum_of_average_item_price_for_each_merchant
    merchants.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
  end

  def total_number_of_items_per_merchant
    @_total ||= merchants.map do |merchant|
      @engine.items.find_all_by_merchant_id(merchant.id).count
    end
  end

  def total_merchants
    merchants.length
  end
end
