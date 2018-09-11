require 'pry'





class SalesAnalyst

  def initialize(sales_engine)
    @engine = sales_engine
    @merchants = @engine.merchants.all
    @items = @engine.items.all
    # binding.pry
  end

  def average_items_per_merchant
    groups = @items.group_by { |item|  item.merchant_id }
    count  = groups.group_by { |group| group.count.to_f }
    # count  = groups.values.group_by { |group| group.count.to_f }
    # ONLY THE FIRST ELEMENT IS BEING RETURNED
    each_count = count.keys
    qty_merchants = count.keys.count.to_f
    binding.pry
    sum = each_count.inject(0) {|sum, ct| sum += ct } # .sum doesn't work in this version
    average = sum / qty_merchants
    # binding.pry
    return average
  end

  def average_items_per_merchant_standard_deviation

  end

end
