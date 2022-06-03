require 'CSV'
class SalesAnalyst
  attr_accessor :item_repository, :merchant_repository

  def initialize(item_repository, merchant_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
  end

  def average_items_per_merchant

  end

end
