class SalesAnalyst

  def initialize(parent)
    @parent = parent
  end

  def average_items_per_merchant
    items = @parent.items.all
    grouped_items = items.group_by {|item| item.merchant_id}
    items_per_merchant = grouped_items.map {|merchant_id, items| items.count}
    total_items = items_per_merchant.inject(0.0){|sum, item_count| sum += item_count}
    (total_items / items_per_merchant.count).round(2)
  end
end
