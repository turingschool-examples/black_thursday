class SalesAnalyst
  attr_reader :merchant_repo, :item_repo, :transaction_repo, :invoice_item_repo, :invoice_repo, :customer_repo, :merchant_items_hash, :num_items_per_merchant, :set_of_square_differences, :big_box_ids

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
    @big_box_ids = []
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

  def merchants_with_high_item_count
    high_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
   group_items_by_merchant_id.each do |id, items|
      if items.count > high_count
        @big_box_ids << id
      end
    end
    big_boxes = @merchant_repo.all.find_all { |merchant| @big_box_ids.include?(merchant.id)}
  end

  def average_item_price_for_merchant(merchant_id)
    prices = group_items_by_merchant_id[merchant_id].map { |item| item.unit_price }
    prices.sum / prices.count
  end

  def average_average_price_for_merchant
    all_merchant_ids = @merchant_repo.all.map { |merchant| merchant.id }
    merchant_averages = all_merchant_ids.map { |id| average_item_price_for_merchant(id) }
    merchant_averages.sum / merchant_averages.count
  end

  def average_item_price_standard_deviation
    all_item_prices = @item_repo.all.map { |item| item.unit_price }
    mean = all_item_prices.sum / all_item_prices.count
    differences = all_item_prices.map { |item_price| item_price - mean }
    square_differences = differences.map { |difference| difference**2 }
    sum_square_differences = square_differences.sum
    quotient = sum_square_differences / (all_item_prices.count - 1)
    st_dev = Math.sqrt(quotient).round(2)
  end

  def golden_items
    all_item_prices = @item_repo.all.map { |item| item.unit_price }
    mean = all_item_prices.sum / all_item_prices.count
    golden_price = mean + (average_item_price_standard_deviation * 2)
    golden_items = @item_repo.all.find_all { |item| item.unit_price > golden_price }
  end



end
