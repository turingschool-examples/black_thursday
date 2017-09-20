module MerchantTopRevenueEarners

  def merchant_id_and_total_grouped
    merchant_id_and_total_grouped = Hash.new(0)
    sales_engine.invoices.all.map do |invoice|
      merchant_id_and_total_grouped[invoice.merchant_id] = invoice.total
    end
  end

  def single_merchant_id_with_total_revenue
    merchant_id_and_total_grouped.map! do |key, value|
      key +=value
    end
    merchant_id_and_total_grouped.sort_by {|key, value| value}
  end

  def merchants_by_revenue
    top_revenue_by_id = single_merchant_id_with_total_revenue.map do |key, value|
      key
    end
    top_merchants = []
     top_revenue_by_id.each do |id|
       top_merchants << sales_engine.merchants.find_by_id(id)
     end
   end



end
