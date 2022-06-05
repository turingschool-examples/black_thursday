class SalesAnalyst
  attr_reader :items_path, :merchants_path
  def initialize(items_path, merchants_path)
    @items_path = items_path
    @merchants_path = merchants_path
  end

  def average_items_per_merchant
    # (@items_path.all.count.to_f / @merchants_path.all.count).round(2)
    mean = array_of_sums.reduce(:+).to_f / array_of_sums.count
    mean.round(2)
  end

  def group_by_merchant_id
    @items_path.all.group_by do |item|
      item.merchant_id
    end
  end

  def array_of_sums
    group_by_merchant_id.map do |id, items|
      items.count
    end
  end

  def step_1
    bunny = array_of_sums.map do |sum|
      (sum - average_items_per_merchant)**2
    end.sum
  end

  def average_items_per_merchant_standard_deviation
    variance = step_1 / (array_of_sums.count - 1)
    standard_deviation = Math.sqrt(variance).round(2)
  end
end
