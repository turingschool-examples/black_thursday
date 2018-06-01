module ItemAssistant
  def all_item_prices
    total = @items.members.map do |item|
      item.unit_price
    end
  end

  def items_by_merchant_id
    items_per_merchant = Hash.new(0)
    @items.members.each do | item |
      items_per_merchant[item.merchant_id] += 1
    end
    items_per_merchant
  end

  def merchant_ids_with_more_items_than_one_standard_deviation
    higher_than = average_items_per_merchant + average_items_per_merchant_standard_deviation
    ids = items_by_merchant_id.keys.map do | merchant |
      if items_by_merchant_id[merchant] > higher_than
        merchant
      end
    end.compact
  end
end
