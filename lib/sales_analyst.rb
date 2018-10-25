class SalesAnalyst
  # def merchants_with_high_item_count
  #
  # end

  def average_item_price_for_merchant(id)
    list = @items.find_all_by_merchant_id(id)
    total = 0
    count = 0
    list.each do |item|
      item.unit_price += total
      count += 1
    end
    total / count
  end


end
