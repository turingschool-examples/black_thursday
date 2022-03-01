class SalesAnalyst
  attr_reader :merchant_repo, :item_repo, :merchant_items_hash, :num_items_per_merchant
  def initialize(merchant_repo, item_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
    @merchant_items_hash = {}
    @num_items_per_merchant = []
    @mean = 0
    @set_of_square_differences = []
  end

  def group_items_by_merchant_id
    @merchant_items_hash = @item_repo.all.group_by { |item| item.merchant_id }
  end

  def items_per_merchant
    group_items_by_merchant_id
    @num_items_per_merchant = @merchant_items_hash.map do |merchant, items|
      items.count
    end
  end
  #
  # def square_differences
  #   average_items_per_merchant
  #   set = @num_items_per_merchant.map do |number|
  #     number - @mean
  #     binding.pry
  #   end
  # end
  #
  #
  # def average_items_per_merchant
  #   # avg = @item_repo.all.count.to_f / @merchant_repo.all.count.to_f
  #   items_per_merchant
  #   avg = items_per_merchant.sum.to_f / items_per_merchant.count
  #   @mean = avg.round(2)
  # end
  #
  # def average_items_per_merchant_standard_deviation
  # end
end
