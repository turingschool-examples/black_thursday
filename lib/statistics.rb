module Statistics
  def standard_deviation(*nums)
    av = average(*nums)
    diffs = nums.map{|n| n - av}
    Math.sqrt(diffs.map{|n|n**2}.inject(&:+).to_f / (nums.size - 1).to_f)
  end

  def average(*nums)
    nums.inject(&:+) / nums.size.to_f
  end

  def average_type_per_type(type_1, type_2)
    (type_1.all.size.to_f / type_2.all.size).round(2)
  end

  def average_items_per_merchant
    average_type_per_type(@items, @merchants)
  end

  def average_invoices_per_merchant
    average_type_per_type(@invoices, @merchants)
  end

  def average_items_per_merchant_standard_deviation
    items_per_each_merchant = @items.all.group_by{ |item| item.merchant_id }.map{ |k,v| v.size }
    standard_deviation(*items_per_each_merchant).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_each_merchant = @invoices.all.group_by{|iv|iv.merchant_id}.map{|k,v|v.size}
    standard_deviation(*invoices_per_each_merchant).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    prices = @items.find_all_by_merchant_id(merchant_id).map(&:unit_price)
    return nil if prices == []
    BigDecimal(average(*prices).to_f.round(2).to_s)
  end

  def average_average_price_per_merchant
    averages = @merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(*averages).round(2)
  end

  def sum(*nums)
    nums.reduce(0) do |sum, object|
      if block_given?
        sum += yield( object )
      else
        sum += object
      end
    end
  end
end
