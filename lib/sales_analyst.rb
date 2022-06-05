class SalesAnalyst
  attr_reader :items_path, :merchants_path
  def initialize(items_path, merchants_path)
    @items_path = items_path
    @merchants_path = merchants_path
  end

  def average_items_per_merchant
    sum = array_of_sums.inject do |sum, element|
       sum + element
     end
     mean = sum.to_f / array_of_sums.count
     mean.round(2)

  end

  def group_by_merchant_id
    frog = @items_path.all.group_by do |item|
      item.merchant_id
    end
  end

  def array_of_sums
  chicken = group_by_merchant_id.map do |id, items|
      items.count
    end
  end
end
