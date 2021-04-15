require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def find_all(category)
    @sales_engine.category.all
  end

  def average_items_per_merchant
    item_merchant_ids = @sales_engine.items.all.map do |item|
      item.merchant_id
    end

    merchant_item_matches = @sales_engine.merchants.all.map do |merchant|
      item_merchant_ids.map do |item_id|
        merchant.id == item_id
      end
    end

    count = merchant_item_matches.map do |array|
      array.count(true)
    end
    average_items = count.sum.to_f / @sales_engine.merchants.all.count
    average_items.round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_merchant_ids = @sales_engine.items.all.map do |item|
      item.merchant_id
    end

    merchant_item_matches = @sales_engine.merchants.all.map do |merchant|
      item_merchant_ids.map do |item_id|
        merchant.id == item_id
      end
    end

    count = merchant_item_matches.map do |array|
      array.count(true)
    end
    avg = average_items_per_merchant
    #sample variance
    sum = count.inject(0) do |accum, i|
      accum + (i - avg) ** 2
    end
    sample_variance = sum / (count.length - 1).to_f
    #std deviation
    standard_deviation = (Math.sqrt(sample_variance)).round(2)
  end

  def merchants_with_high_item_count
    #return an array of merchant objects > 1 std deviation above avg # of
    #products offered
    # 1 std deviation = standard_deviation + avg
    # so anything greater than the number above will work
    # I added an item called Pixie Dust to the items csv so 1 merchant has 2 items. merchant_id = 12334105

    #need assistance with pulling down the merchant objects that match >1 std deviation criteria 
  end
end
