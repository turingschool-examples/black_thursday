require 'pry'





class SalesAnalyst

  def initialize(sales_engine)
    @engine = sales_engine
    @merchants = @engine.merchants.all
    @items = @engine.items.all
    # binding.pry
  end

  def standard_deviation(values, mean)
    # each value - mean
    # each difference ^2
    # sum squares
    # sum / (ct -1)
    # Math.sqrt(above)

  end



  def average_items_per_merchant
    groups = @items.group_by { |item| item.merchant_id }
    sum = groups.values.inject(0){ |ct, store| ct += store.count.to_f }
    merchants_ct = groups.keys.count.to_f
    average = sum / merchants_ct
    return average.round(2)
  end

  def average_items_per_merchant_standard_deviation

  end



end
