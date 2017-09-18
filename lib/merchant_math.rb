module MerchantMath

  def average_things_per_merchant(merchants_and_things)
    total_things = merchants_and_things.values.sum
    total_merchants = merchants_and_things.length
    (total_things/total_merchants).round(2)
  end

  def average_things_per_merchant_standard_deviation(merchants_and_things)
    average = average_things_per_merchant(merchants_and_things)
    individual_minus_average = []
    individual_minus_average << merchants_and_things.values.map do |number_of_things|
                                  number_of_things - average
                                end
    individual_minus_average_squared = individual_minus_average.flatten.map {|num| num ** 2}
    std_dev_top = individual_minus_average_squared.sum
    number_of_elements = merchants_and_things.values.count
    Math.sqrt(std_dev_top / (number_of_elements - 1)).round(2)
  end

  def make_merchants_and_things(things)
    thing_array = things.all
    merchant_ids = thing_array.map do |thing|
                     thing.merchant_id
                   end
   thing_counts = Hash.new 0
   merchant_ids.each do |merchant_id|
     thing_counts[merchant_id] += 1.0
   end
   return thing_counts
  end

end
