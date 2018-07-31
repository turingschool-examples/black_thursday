require_relative 'item_repository'

class ItemAnalyst
  def initialize(item_repository)
    @item_repo = item_repository
  end

  def group_item_by_merchant_id
    @item_repo.all.group_by { |item| item.merchant_id }
  end

  def number_of_merchants
    group_item_by_merchant_id.keys.count
  end

  def average_items_per_merchant
    (@item_repo.all.size / number_of_merchants.to_f).round(2)
  end
end
