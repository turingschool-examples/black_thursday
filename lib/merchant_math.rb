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

################

  def average_thing(things)
    all_things_sum = 0
    things.all.each do |thing|
       all_things_sum += thing.unit_price_float
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

    def two_standard_deviations_below(things, comparison_class)
      golden_things_list = []
        things.all.each do |thing|
          if (thing.unit_price_float)  <= avg_thing_plus_2x_std_dev(things, comparison_class)
          golden_things_list << thing
          puts "Yowza - 2 STDs below"
          end
        end
        golden_things_list
      end


      def one_standard_deviations_above(things, comparison_class)
        golden_things_list = []
          things.all.each do |thing|
            if (thing.unit_price_float)  >= standard_deviation_for_thing(things, comparison_class)
            golden_things_list << thing
            puts "Yowza - 1 STD above"
            end
          end
          golden_things_list
        end


end
