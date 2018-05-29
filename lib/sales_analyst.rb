
class SalesAnalyst
  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def average_items_per_merchant
    items_per_merchant = Hash.new(0)
    @items.each do | item |
      items_per_merchant[item.merchant_id] += 1
    end
    sum = items_per_merchant.values.inject(0) {| sum, n | sum+n}

    return (sum.to_f / items_per_merchant.values.length.to_f).round(2)
  end
end
