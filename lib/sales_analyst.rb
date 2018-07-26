class SalesAnalyst
  attr_reader :se

  def initialize(sales_engine)
    @se = sales_engine
  end

  def group_items_by_merchant
    @se.items.all.group_by do |item|
      item.merchant_id
    end
  end

  def items_per_merchant
  group_items_by_merchant.values.map(&:count)
  end

  def average_items_per_merchant
    total_items = items_per_merchant.inject(0) do |sum, item_count|
      sum + item_count
    end
    ((total_items).round(2) / items_per_merchant.length.round(2)).round(2)
  end

end
