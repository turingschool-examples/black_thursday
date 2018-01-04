require 'descriptive-statistics'

class SalesAnalyst

  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (se.item_repository.items.count / se.merchant_repository.merchants.count.to_f).round(2)
  end

end
