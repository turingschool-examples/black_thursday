class SalesAnalyst
  attr_reader :merchant_repo, :item_repo, :transaction_repo, :invoice_item_repo, :invoice_repo, :customer_repo, :merchant_items_hash, :num_items_per_merchant, :set_of_square_differences

  def initialize(merchant_repo, item_repo, transaction_repo, invoice_item_repo, invoice_repo, customer_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
    @transaction_repo = transaction_repo
    @invoice_item_repo = invoice_item_repo
    @invoice_repo = invoice_repo
    @customer_repo = customer_repo
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

  def average_items_per_merchant
    items_per_merchant
    avg = items_per_merchant.sum.to_f / items_per_merchant.count
    @mean = avg.round(2)
  end

  def square_differences
    average_items_per_merchant
    differences = @num_items_per_merchant.map { |number| number - @mean }
    @set_of_square_differences = differences.map { |difference| (difference**2).round(2) }
  end

  def average_items_per_merchant_standard_deviation
    square_differences
    sum_sq_diff = @set_of_square_differences.sum
    result = sum_sq_diff / (@num_items_per_merchant.count - 1)
    Math.sqrt(result).round(2)
  end
end
