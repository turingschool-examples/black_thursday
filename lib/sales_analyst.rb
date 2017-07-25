
class SalesAnalyst
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    ((@se.item.all.count.to_f) / (@se.merchant.all.count.to_f)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    set = set_of_merchant_items
    mean = set.inject(:+).to_f / set.size
    Math.sqrt(set.inject(0){|sum,val| sum + (val - mean)**2} / set.size).round(2)
  end

  def set_of_merchant_items
    set = []
    @se.merchant.all.map do |merchant|
      set << merchant.items.count
    end
    set
  end

  def merchants_with_high_item_count
    @se.merchant.all.find_all do |merchant|
      merchant.items.count > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
  end

  


end
