require './lib/sales_engine.rb'


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

#Helper method that loads the data
  def get_data
    @data = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",})
    return data
  end
end
