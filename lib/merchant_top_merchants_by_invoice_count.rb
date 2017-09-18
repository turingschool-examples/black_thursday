module MerchantTopMerchantsByInvoiceCount

  def group_invoices_by_merchant
    merchant_ids = sales_engine.invoices.all.map do |invoice|
      #collects an array of just merchant ids, not the instances.
      invoice.merchant_id

     end
   invoice_counts = Hash.new 0  #create an empty hash to fill
   merchant_ids.each do |merchant_id| #take the array of plain merchant_ids, and use them to make a key value where we add to the value each time there is another invoices
     invoice_counts[merchant_id] += 1.0
   end
   return invoice_counts #this is a hash of merchant_id => integer (representing how many invoices they have)
     puts "group_invoices_by_merchant done"
  end

  def average_invoices_per_merchant
    sales_engine.invoices.all.count / sales_engine.merchants.all.count
    puts "average_invoices_per_merchant done"
  end

def merchant_invoices_numerator
  numerator = 0
  binding.pry
   group_invoices_by_merchant.each do |key, value|
     numerator += (value - average_invoices_per_merchant)**2
   end
   numerator
   puts "merchant_invoices_numerator done"
end

  def merchant_invoices_denominator_and_sqrt
    # binding.pry -- shows merchant invoices numerator doesn't work
    Math.sqrt(merchant_invoices_numerator/(sales_engine.merchants.all.count - 1))
    puts "merchant_invoices_denominator_and_sqrt done"
  end

  def standard_deviation_for_merchant_invoices
    group_invoices_by_merchant
    average_invoices_per_merchant
    merchant_invoices_numerator
    merchant_invoices_denominator_and_sqrt
    puts "standard_deviation_for_merchant_invoices done"
  end

  def two_standard_deviations_above_merchant_invoices
    average_invoices_per_merchant + standard_deviation_for_merchant_invoices * 2
    puts "two_standard_deviations_above_merchant_invoices done"
  end



end
