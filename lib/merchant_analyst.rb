module MerchantAnalyst

  def average_items_per_merchant
    (total_items/total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    calculate_std_dev
  end

  def find_items_per_merchant
    pull_all_merchant_ids.map do |merchant_id|
      @sales_engine.items.find_all_by_merchant_id(merchant_id).count
    end
  end

  def calculate_std_dev
    sum = find_items_per_merchant.reduce(0) do |result, merchant|
      squared_difference = (average_items_per_merchant - merchant) ** 2
      result + squared_difference
    end
    Math.sqrt(sum / (total_merchants-1)).round(2)
  end

  def merchants_and_item_count
    Hash[pull_all_merchant_ids.zip find_items_per_merchant]
  end

  def merchants_with_high_item_count
    high_item_count_merchant_ids.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def high_item_count_merchant_ids
    merchants_and_item_count.map do |merchant_id,item_count|
      merchant_id if item_count > (average_items_per_merchant + calculate_std_dev)
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    item_prices = @sales_engine.items.items.map do |item|
      item.unit_price if item.merchant_id == merchant_id
    end.compact
    (item_prices.sum/item_prices.length).round(2)
  end

  def average_average_price_per_merchant
    average_price = @sales_engine.merchants.all.reduce(0) do |result,merchant|
      result += average_item_price_for_merchant(merchant.id)
    end/total_merchants
    average_price.round(2)
  end

  def total_revenue_by_date(date)
    find_invoices_by_date(date)
  end

  def find_invoices_by_date(date)
    invoices = @sales_engine.invoices.all.find_all do |invoice|
      invoice.created_at == date
    end
    find_invoice_items_by_invoice_date(invoices)
  end

  def find_invoice_items_by_invoice_date(invoices)
    invoice_items = invoices.map do |invoice|
      @sales_engine.find_invoice_items_by_invoice_id(invoice.id)
    end.flatten
    calculate_total_revenue_by_date(invoice_items)
  end

  def calculate_total_revenue_by_date(invoice_items)
    invoice_items.reduce(0) do |result, invoice_item|
      result += (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  def revenue_by_invoice_id
    @sales_engine.invoice_items.all.reduce(Hash.new(0)) do |result, invoice_item|
      result[invoice_item.invoice_id] += (invoice_item.quantity * invoice_item.unit_price)
      result
    end
  end

  def revenue_by_merchant_id
    revenue_by_invoice_id.reduce(Hash.new(0)) do |result, (invoice_id, revenue)|
      if @sales_engine.invoices.find_by_id(invoice_id).is_paid_in_full?
        result[@sales_engine.invoices.find_by_id(invoice_id).merchant_id] += revenue
      else
        result[@sales_engine.invoices.find_by_id(invoice_id).merchant_id] += 0
      end
      result
    end
  end

  def revenue_for_each_merchant
    revenue_by_merchant_id.reduce(Hash.new(0)) do |result, (merchant_id, revenue)|
      result[@sales_engine.merchants.find_by_id(merchant_id)] += revenue
      result
    end
  end

  def merchants_ranked_by_revenue
    revenue_for_each_merchant.sort_by do |_, revenue|
      -revenue
    end.map(&:first)
  end

  def top_revenue_earners(amount = 20)
    merchants_ranked_by_revenue.first(amount)
  end

  def find_pending_invoices
    @sales_engine.invoices.all.find_all do |invoice|
      !invoice.is_paid_in_full?
    end
  end

  def find_pending_merchant_ids
    find_pending_invoices.map do |invoice|
      invoice.merchant_id
    end.uniq
  end

  def merchants_with_pending_invoices
    find_pending_merchant_ids.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item
    merchant_ids_with_one_item.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchant_ids_with_one_item
    merchants_and_item_count.find_all do |merchant, item_count|
      item_count == 1
    end.map(&:first)
  end

  def merchants_with_only_one_item_registered_in_month(provided_month)
  #   merchant_id_by_month = @sales_engine.invoices.all.reduce(Hash.new(0)) do |result, invoice|
  #     if invoice.created_at.strftime("%B") == provided_month
  #       result[invoice.merchant_id] += 1
  #     end
  #     result
  #   end
  #   thing = merchant_id_by_month.reduce([]) do |result, (merchant_id, count)|
  #     if count == 1
  #       result << merchant_id
  #     end
  #     result
  #   end
  #   # binding.pry

  merchant_ids_with_one_item.find_all do |merchant|
    merchants.created_at.strftime("%B") == provided_month
    end
  end

  def revenue_by_merchant(merchant_id)
    revenue_by_merchant_id[merchant_id]
  end

  def most_sold_item_for_merchant(merchant_id)
    items_by_quantity = @sales_engine.invoice_items.all.reduce(Hash.new(0)) do |result, invoice_item|
      result[invoice_item.item_id] += invoice_item.quantity
      result
    end
    items_by_quantity.reduce(Hash.new(0)) do |result, (item_id, quantity)|
      result[@sales_engine.items.find_by_id(item_id)] += quantity
      result
    end
  end



end
