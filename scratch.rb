top_merchants_by_invoice_count

return merchants who have a number of invoices that are 2 STDs above the mean for number of invoices per merchant.


find average number of invoices per merchants
compare number of each merchants invoices to the standard deviation num of invoices
return the merchant objects which meet the conditions

def average_thing(MERCHANT_INVOICES)
  all_things_sum = 0
  MERCHANT_REPO.all.each do |MERCHANT|
     all_things_sum += MERCHANT.INVOICE
  end
  all_things_sum / things.all.count
end

def square_each_thing_average_difference(things)
  calculation_thing_array_sum = 0
  things.all.each do |thing|
    calculation_thing_array_sum += ((thing.unit_price_float) - (average_thing(things))) ** 2
  end
  calculation_thing_array_sum
end

def standard_deviation_for_thing(things, comparison_class)
  final = Math.sqrt(square_each_thing_average_difference(things) / (comparison_class.all.count - 1))
  final.round(3)
end

def avg_thing_plus_2x_std_dev(things, comparison_class)
  average_thing(things) + (standard_deviation_for_thing(things, comparison_class) * 2)
 end


  # need to pass in the two se.objects that are needed for comparison. first is the main thing being compared. the second is the less
def two_standard_deviations_above(things, comparison_class)
  golden_things_list = []
    things.all.each do |thing|
      if (thing.unit_price_float)  >= avg_thing_plus_2x_std_dev(things, comparison_class)
      golden_things_list << thing
      puts "Yowza - 2 STDs above"
      end
    end
    golden_things_list
  end

################################
bottom_merchants_by_invoice_count

Which merchants are more than two standard deviations below the mean?

sa.bottom_merchants_by_invoice_count # => [merchant, merchant, merchant]
