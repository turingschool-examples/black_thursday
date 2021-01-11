module Mathematics

  def find_invoice_per_merchant_average
    (@invoices.all.count.to_f / @merchants.merchant_list.count.to_f).round(2)
  end

  def find_average
    (@items.item_list.count.to_f / @merchants.merchant_list.count.to_f).round(2)
  end

  def count_merchants
    total_count = @merchants.merchant_list.reduce([]) do |acc, merchant|
      acc << merchant.item_name.count
      acc
    end
  end

  def standard_deviation
    sum = count_merchants.sum do |value|
      ((value - find_average)**2)
    end

    result = (sum / (@merchants.merchant_list.count.to_f - 1))
    Math.sqrt(result).round(2)
  end

  def count_invoices
    total_invoices = @invoices.all.reduce([]) do |acc, invoice|
      acc << invoice.merchant.count
      acc
    end
  end

  def standard_deviation_for_merchant_invoices
    sum = count_invoices.sum do |value|
      ((value - find_invoice_per_merchant_average)**2)
    end
    result = (sum / ((@invoices.all.count.to_f + @merchants.merchant_list.count.to_f) - 1))
    Math.sqrt(result).floor(2)
  end

  def count_merchants_items
    @merchants.merchant_list.reduce({}) do |acc, merchant|
      acc[merchant] = merchant.item_name.count
      acc
    end
  end

  def find_merchants_with_most_items
    merchant_deviation = (find_average + standard_deviation)

    count_merchants_items.select do |key, value|
      value >= merchant_deviation
    end
  end

  def calculate_highest_invoice_deviation
    invoice_deviation = (find_invoice_per_merchant_average +
     (standard_deviation_for_merchant_invoices * 2))
  end

  def find_top_merchants_by_invoice_count
    deviation = calculate_highest_invoice_deviation
    highest_merchants = create_invoices_per_merchant_hash.select do |key, value|
      value >= deviation
    end

    highest_merchants.map do |merchant_id, invoices|
      find_merchant_by_merchant_id(merchant_id)
    end
  end

  def create_invoices_per_merchant_hash
    @invoices.all.reduce({}) do |acc, invoice|
      acc[invoice.merchant_id] = invoice.merchant.count
      acc
    end
  end

  def calculate_invoice_lowest_deviation
    invoice_lowest_deviation = (find_invoice_per_merchant_average -
      (standard_deviation_for_merchant_invoices * 2))
  end

  def find_bottoms_merchants_by_invoice_count
    deviation = calculate_invoice_lowest_deviation
    lowest_merchants = create_invoices_per_merchant_hash.select do |key, value|
      value <= deviation
    end

    lowest_merchants.map do |merchant_id, invoices|
      find_merchant_by_merchant_id(merchant_id)
    end
  end
end
