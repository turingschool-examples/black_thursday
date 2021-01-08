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

  def average_item_price_for_merchant(id)
    @parent.find_merchant_by_id(id)
  end
end