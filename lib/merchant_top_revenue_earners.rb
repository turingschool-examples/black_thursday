module MerchantTopRevenueEarners

  def merchant_id_and_total_grouped #works
    merchant_id_and_total_grouped = Hash.new(0)
    sales_engine.invoices.all.each do |invoice|
      merchant_id_and_total_grouped[invoice.merchant_id] += invoice.total
      puts "MerchantTopRevenueEarners, 7"
    end
    merchant_id_and_total_grouped
  end

  def single_merchant_id_with_total_revenue
    whatever = merchant_id_and_total_grouped
    sorted = whatever.sort_by {|key, value| value}.reverse
    puts sorted
    sorted
  end





end
