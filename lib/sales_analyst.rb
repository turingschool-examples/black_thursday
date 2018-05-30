
class SalesAnalyst
  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    items_per_merchant = Hash.new(0)
    @items.members.each do | item |
      items_per_merchant[item.merchant_id] += 1
    end
    sum = items_per_merchant.values.inject(0) {| sum, n | sum+n}

    return (sum.to_f / items_per_merchant.values.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = Hash.new(0)
    @items.members.each do | item |
      items_per_merchant[item.merchant_id] += 1
    end

    subtracted_and_squared = items_per_merchant.values.map do | merchant |
      (merchant - average_items_per_merchant) ** 2
    end

    sum = subtracted_and_squared.inject(0) {| sum, n | sum+n}

    divided = sum / (subtracted_and_squared.length - 1)
    sd = Math.sqrt(divided)
    sd.round(2)
  end

  def merchants_with_high_item_count
    items_per_merchant = Hash.new(0)
    @items.members.each do | item |
      items_per_merchant[item.merchant_id] += 1
    end
    higher_than = average_items_per_merchant + average_items_per_merchant_standard_deviation
    ids = items_per_merchant.keys.map do | merchant |
      if items_per_merchant[merchant] > higher_than
        merchant
      end
    end.compact

    ids.map do | merchant |
      @merchants.find_by_id(merchant)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    divided_by = 0
    total = @items.members.inject(0) do | sum, item |
      if item.merchant_id == merchant_id
        divided_by += 1
        sum += item.unit_price
      end
      sum
    end

    (total / divided_by).round(2)
  end

  def average_average_price_per_merchant
    total = @merchants.members.inject(0) do | sum, merchant |
      sum += average_item_price_for_merchant(merchant.id)
      sum
    end

    (total/@merchants.members.length).round(2)
  end

  def golden_items
    price_total = @items.members.inject(0) do | sum, item |
      sum += item.unit_price
      sum
    end

    price_mean = price_total / @items.members.length

    sd_sum = @items.members.inject(0) do | sum, item |
      difference = item.unit_price - price_mean
      square = difference ** 2
      sum += square
    end

    sd_division = sd_sum / (@items.members.length-1)

    sd = Math.sqrt(sd_division)

    greater_than = price_mean + (2 * sd)

    @items.members.map do | item |
      if item.unit_price >= greater_than
        item
      end
    end.compact
  end
end
