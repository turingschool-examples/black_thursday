class SalesAnalyst

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    se.item_repository.items.group_by
  end

end
