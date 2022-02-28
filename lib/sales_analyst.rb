require_relative 'sales_engine'


class SalesAnalyst
  attr_accessor :data, :id_counter
  def initialize
  @items_array = []
  @merchants_array = []
  end

  def average_items_per_merchant
    get_data
      return (data.items_array.length.to_f/data.merchants_array.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant
    total_to_be_square_rooted = 0.0
    @id_counter.each do |index|
      total_to_be_square_rooted += (average_items_per_merchant.to_f - index[1].to_f)**2
    end
    return ((total_to_be_square_rooted/(data.merchants_array.length.to_f - 1))**0.5).round(2)
  end

  def merchants_with_high_item_count
    average_items_per_merchant_fixed = average_items_per_merchant
    average_items_per_merchant_standard_deviation_fixed = average_items_per_merchant_standard_deviation
    id_counter_fixed = @id_counter
    high_item_count =  id_counter_fixed.find_all {|index| index[1] >= average_items_per_merchant_standard_deviation_fixed + average_items_per_merchant_fixed}
  end

  def average_item_price_for_merchant(merchant_id)
    items_per_merchant
    number_of_items = @id_counter[merchant_id]
    items = data.items_array.find_all{|index| index.merchant_id == merchant_id}
    total_cost = 0.0
    items.each {|index| total_cost += index.unit_price.to_f}
    return BigDecimal(total_cost.to_f/number_of_items.to_f,4)
  end

  def average_item_price_per_merchant
    items_per_merchant
    id_counter_fixed = @id_counter
    sum_of_all_averages = 0.0
    id_counter_fixed.keys.each {|index| sum_of_all_averages += average_item_price_for_merchant(index)}
    sum_of_all_averages / data.merchants_array.length.to_f
  end

  def golden_items
    standard_deviation_of_item_price_fixed = standard_deviation_of_item_price
    average_item_price_fixed = average_item_price
    data.items_array.find_all {|index| index.unit_price.to_f > (average_item_price_fixed + standard_deviation_of_item_price_fixed + standard_deviation_of_item_price_fixed) }
  end
#helper method that returns a hash with every
#merchant id and the number of items that
#merchant has
  def items_per_merchant
    get_data
    @id_counter = Hash.new(0)
    data.items_array.each do |index|
      id_counter[index.merchant_id] += 1
    end
    return @id_counter
  end

  def average_item_price
    get_data
    cost_of_all_items = 0.0
    data.items_array.each {|index| cost_of_all_items += index.unit_price.to_f}
    return cost_of_all_items/data.items_array.length.to_f
  end


  def standard_deviation_of_item_price
    get_data
    squared_item_price_total = 0.0
    average_item_price_fixed = average_item_price
    data.items_array.each {|index| squared_item_price_total += ((index.unit_price.to_f - average_item_price_fixed)**2)}
    return (squared_item_price_total/(data.items_array.length - 1 ))**0.5
  end
#Helper method that loads the data
  def get_data
    @data = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",})
    return data
  end

end
