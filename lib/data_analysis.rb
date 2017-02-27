module DataAnalysis

  def std_dev_from_array(array)
    array.map!{|num| num.to_f }
    mean = array.reduce(:+)/array.length
    sum_sqr = array.map {|number| number * number}.reduce(:+)
    Math.sqrt((sum_sqr - array.length * mean * mean)/(array.length - 1)).round(2)
  end

  def average_of_items(item_1, item_2)
    # by default, could accept one argument and divide by arg count
    # perhaps optional 2nd arg, if included, divide item_1 by item_2?
    (item_1.to_f / item_2.to_f).round(2)
  end


end
