require 'pry'





class SalesAnalyst

  attr_reader :engine, :merchants, :items

  def initialize(sales_engine)
    @engine = sales_engine
    @merchants = @engine.merchants.all
    @items = @engine.items.all
    # binding.pry
  end

  # --- General Methods ---

  def group_by(repo, method)
    groups = repo.group_by { |object| object.send(method)}  #method is a symbol
  end

  def average(values)
    sum = values.inject(0) { |tot, val| tot += val.to_f }
    ct = values.count.to_f
    average = (sum / ct) #.round(2)
  end

  def standard_deviation(values, mean)
    values = values.each { |val| (val.to_f - mean) ** 2 }     # (each value - mean)**2
    sum = values.inject(0) { |total, val| total += val }      # sum squares
    div = sum / (values.count - 1)                            # sum / (ct -1)
    sqrt = Math.sqrt(div)                                     # Math.sqrt(above)
    return sqrt.round(2)
  end


  # --- Merchant Methods ---

  def average_items_per_merchant
    groups = group_by(@items, :merchant_id)
    vals = groups.values.inject([]) { |arr, store| arr << store.count }
    mean = average(vals)
    return mean.round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    groups = group_by(@items, :merchant_id)
    vals = groups.values.inject([]) { |arr, store| arr << store.count }
    std = standard_deviation(vals, mean)
  end




end
