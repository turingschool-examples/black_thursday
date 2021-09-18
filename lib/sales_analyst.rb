class SalesAnalyst

  attr_reader :items,
              :merchants,
              :merch_item_hash

  def initialize(items, merchants)
    @items = items.all
    @merchants = merchants.all
    @merch_item_hash = hash_create
  end

  def hash_create
    return_hash = {}
    @merchants.each do |merchant|
      @items.each do |item|
        if merchant.id == item.merchant_id
          if return_hash[merchant.name].nil?
            return_hash[merchant.name] = [item]
          else
            return_hash[merchant.name] += [item]
          end
        end
      end
    end
    return_hash
  end

  def average_items_per_merchant
    num_merchants = @merchants.length.to_f
    num_items = @items.length.to_f
    expected = (num_items / num_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sum_diff_squared = 0
    @merch_item_hash.each do |merchant,items|
      sum_diff_squared += (items.length - average_items_per_merchant) ** 2
    end
    ((sum_diff_squared / @merchants.length.to_f) ** 0.5).round(2)
  end

  def merchants_with_high_item_count
    return_array = []
    @merch_item_hash.each do |merchant,items|
      if items.length >= average_items_per_merchant_standard_deviation
        return_array.push(merchant)
      end
    end
    return_array
  end

end
