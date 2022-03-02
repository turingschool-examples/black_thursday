class SalesAnalyst
  attr_reader :merchant_repo, :item_repo, :transaction_repo, :invoice_item_repo, :invoice_repo, :customer_repo,
              :big_box_ids

  def initialize(merchant_repo, item_repo, transaction_repo, invoice_item_repo, invoice_repo, customer_repo)
    @merchant_repo = merchant_repo
    @item_repo = item_repo
    @transaction_repo = transaction_repo
    @invoice_item_repo = invoice_item_repo
    @invoice_repo = invoice_repo
    @customer_repo = customer_repo
    @big_box_ids = []
  end

  def group_items_by_merchant_id
    @item_repo.all.group_by { |item| item.merchant_id }
  end

  def items_per_merchant
    group_items_by_merchant_id.map { |merchant_id, items| items.count }
  end

  def average_items_per_merchant
    items_per_merchant
    (items_per_merchant.sum.to_f / items_per_merchant.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    calculate_st_dev(items_per_merchant)
  end

  def calculate_st_dev(numbers_array)
    mean = numbers_array.sum.to_f / numbers_array.count
    differences = numbers_array.map { |number| number - mean }
    square_differences = differences.map { |difference| difference**2 }
    sum_square_differences = square_differences.sum
    quotient = sum_square_differences / (numbers_array.count - 1)
    Math.sqrt(quotient).round(2)
  end

  def merchants_with_high_item_count
    high_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    group_items_by_merchant_id.each do |id, items|
      if items.count > high_count
        @big_box_ids << id
      end
    end
    big_boxes = @merchant_repo.all.find_all { |merchant| @big_box_ids.include?(merchant.id) }
  end

  def average_item_price_for_merchant(merchant_id)
    prices = group_items_by_merchant_id[merchant_id].map { |item| item.unit_price }
    (prices.sum / prices.count).round(2)
  end

  def average_average_price_per_merchant
    all_merchant_ids = @merchant_repo.all.map { |merchant| merchant.id }
    merchant_averages = all_merchant_ids.map { |id| average_item_price_for_merchant(id) }
    (merchant_averages.sum / merchant_averages.count).round(2)
  end

  def average_item_price_standard_deviation
    all_item_prices = @item_repo.all.map { |item| item.unit_price }
    calculate_st_dev(all_item_prices)
  end

  def golden_items
    all_item_prices = @item_repo.all.map { |item| item.unit_price }
    mean = all_item_prices.sum / all_item_prices.count
    golden_price = mean + (average_item_price_standard_deviation * 2)
    @item_repo.all.find_all { |item| item.unit_price > golden_price }
  end

  def invoice_paid_in_full?(invoice_id)
    transaction = @transaction_repo.all.find { |transaction| transaction.invoice_id == invoice_id }
    if transaction == nil
      return false
    end

    transaction.result == :success
  end

  def invoice_total(invoice_id)
    if invoice_paid_in_full?(invoice_id)
      invoice_items = @invoice_item_repo.all.find_all { |i_item| i_item.invoice_id == invoice_id }
      price_list = invoice_items.map { |i_item| i_item.unit_price * i_item.quantity }
      price_list.sum
    end
  end
end
