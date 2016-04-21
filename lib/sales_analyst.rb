class SalesAnalyst
  attr_reader :merchants, :items, :se

  def initialize(se)
    @se = se
    @merchants = se.merchants
    @items = se.items
  end

  def items_per_merchant
    merchants.all.map do |merchant|
      merchant.items = se.items_by_merchant_id(merchant.id).count
    end
  end

  def average_items_per_merchant
    (items_per_merchant.reduce(:+)/items_per_merchant.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    ipm = items_per_merchant
    av = average_items_per_merchant
    sqdiff = ipm.map do |num|
      (num - av) ** 2
    end
    Math.sqrt(sqdiff.reduce(:+) / (ipm.length - 1)).round(2)
  end

  # def merchants_with_high_item_count
  #   merchants.all.map do |merchant|
  #      (merchant.items.length) > (average_items_per_merchant_standard_deviation + 1)
  #   end
  # end


end
