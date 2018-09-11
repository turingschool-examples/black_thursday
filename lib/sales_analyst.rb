require 'pry'





class SalesAnalyst

  attr_reader :engine, :merchants, :items

  def initialize(sales_engine)
    @engine = sales_engine
    @merchants = @engine.merchants #.all
    @items = @engine.items #.all
    # binding.pry
  end

  # --- General Methods ---

  def group_by(repo, method)
    groups = repo.group_by { |object| object.send(method)}  #method is a symbol
  end   # returns a hash

  # Lets wait to see if this is useful in the other iterations
    #  we can use it in the Item Repo Analysis
  def create_values_array(hash, hash_method, rule_method)
    data    = hash.send(hash_method)
    values  = data.inject([]) {|arr, val| arr << val.send(rule_method) }
  end

  def sum(values)
    sum = values.inject(0) { |total, val| total += val.to_f }
  end   # returns an rounded float

  def average(values, ct = values.count)
    sum     = sum(values)
    ct      = ct.to_f
    average = (sum / ct)
  end   # returns an unrounded float

  def standard_deviation(values, mean) # Explicit steps
    floats      = values.map     { |val| val.to_f   }
    difference  = floats.map     { |val| val - mean }
    values      = difference.map { |val| val ** 2   }
    sample_ct   = (values.count - 1)
    div         = average(values, sample_ct)
    sqrt        = Math.sqrt(div)
    return sqrt.round(2)
  end   # returns float rounded to 2 places


  # --- Item Repo Analysis Methods ---

  def merchant_stores
    groups = group_by(@items.all, :merchant_id)
  end

  def merchant_store_item_counts(groups)
    vals = groups.values.inject([]) { |arr, shop| arr << shop.count }
  end

  def average_items_per_merchant
    groups = group_by(@items.all, :merchant_id)
    vals   = merchant_store_item_counts(groups)
    mean   = average(vals)
    return mean.round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean   = average_items_per_merchant
    groups = merchant_stores
    vals   = merchant_store_item_counts(groups)
    std    = standard_deviation(vals, mean)
  end

  def merchants_with_high_item_count # find all merchants > one std of items
    average   = average_items_per_merchant
    std       = average_items_per_merchant_standard_deviation
    std_high  = average + std
    groups    = merchant_stores
    above = groups.find_all { |merch_id, items| items.count > std_high }.to_h
    merch_ids = above.keys.map { |key| key.to_i}
    list = merch_ids.map { |id| @merchants.all.find { |merch| merch.id == id } }
    list = list.to_a.flatten
    return list
  end

  def average_item_price_for_merchant(id)

  end




end
