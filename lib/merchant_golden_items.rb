module MerchantGoldenItems

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

  def two_standard_deviations_above(things, comparison_class)
    golden_things_list = []
      things.all.each do |thing|
        if (thing.unit_price_float)  >= avg_thing_plus_2x_std_dev(things, comparison_class)
        golden_things_list << thing
        puts "Yowza --  Golden Items!"
        end
      end
      golden_things_list
  end
end
