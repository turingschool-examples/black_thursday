module MerchantTopRevenueEarners

  def merchant_id_and_total_grouped #works
    merchant_id_and_total_grouped = Hash.new(0)
    sales_engine.invoices.all.map do |invoice|
      merchant_id_and_total_grouped[invoice.merchant_id] = invoice.total
    end
    merchant_id_and_total_grouped
  end

  def single_merchant_id_with_total_revenue
    # binding.pry
    merchant_id_and_total_grouped.each do |key, value|
      merchant_id_and_total_grouped[key] = merchant_id_and_total_grouped[key] + value
    end
    sorted = merchant_id_and_total_grouped.sort_by {|key, value| value}.reverse
    merchant_id_and_total_grouped = sorted
  end





end
