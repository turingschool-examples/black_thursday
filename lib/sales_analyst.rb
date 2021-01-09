class SalesAnalyst
  attr_reader :parent

  def initialize(parent)
    @parent = parent
  end

  def average_items_per_merchant
    (all_items_count / all_merchants_count.to_f).round(2)
  end

  def all_items_count
    @parent.items.all #TODO add length
  end

  def all_merchants_count
    @parent.merchants.all.length
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant

    merchant_ids = @parent.merchants.merchants.map do |merchant|
      merchant.id
    end

    items_per_merchant = merchant_ids.map do |id|
      @parent.items.find_all_by_merchant_id(id).count
      # if count > mean then push merchant.find_by_id
    end

    all_items_minus_one = (items_per_merchant.length) - 1

    total = 0
    items_per_merchant.each do |item_number|
      total += ((item_number - mean) ** 2)
    end

    standard_deviaton = Math.sqrt(total / all_items_minus_one)
    standard_deviaton.round(2)
  end

  def merchants_with_high_item_count
    high_seller_count = average_items_per_merchant + average_items_per_merchant_standard_deviation

    merchant_ids = @parent.merchants.merchants.map do |merchant|
      merchant.id
    end
    merchants = []
    merchant_ids.each do |id|
      item_count = @parent.items.find_all_by_merchant_id(id).count
      if item_count > high_seller_count
        merchants << @parent.merchants.find_by_id(id)
      end
    end
    merchants
  end

end