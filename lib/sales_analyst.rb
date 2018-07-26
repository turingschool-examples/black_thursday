class SalesAnalyst
  attr_reader :se

  def initialize(sales_engine)
    @se = sales_engine
  end

  def group_items_by_merchant
    @se.items.all.group_by do |item|
      item.merchant_id
      binding.pry
    end
  end

  def items_per_merchant
    items_grouped_by_merchant.values.map(&:count)
  end

  def average_items_per_merchant
    group_items_by_merchant
  end

end
