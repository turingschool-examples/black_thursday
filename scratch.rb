  def total_item_maker
    @total_items = se.items.all.count
  end



  def average_item_price
    all_item_prices =  []
    se.items.all.each do |item|
       all_item_prices << item.unit_price.to_f * 100
    end
    all_item_prices.sum / total_items
  end

  def square_each_item_average_difference
    calculation_item_array = []
    se.items.all.each do |item|
      # binding.pry
      calculation_item_array << ((item.unit_price.to_f * 100) - (average_item_price)) ** 2
    end
    calculation_item_array.sum
  end

  def standard_deviation_for_item_cost
    final = Math.sqrt(square_each_item_average_difference / (total_items - 1))
    final.round(3)
  end

  def avg_item_price_plus_2x_std_dev

  end

  def golden_items
    golden_items_list = []
    se.items.all.each do |item|
      if (item.unit_price * 100)  >= avg_item_price_plus_2x_std_dev
        golden_items_list << item.name
        puts "Yowza"
      end
    end
      golden_items_list
  end
