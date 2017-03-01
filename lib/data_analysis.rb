module DataAnalysis

  def std_dev_from_array(array)
    array.map!{|num| num.to_f }
    mean = array.reduce(:+)/array.length
    sum_sqr = array.map {|number| number * number}.reduce(:+)
    Math.sqrt((sum_sqr - array.length * mean * mean)/(array.length - 1)).round(2)
  end

  def average(object_1, object_2 = object_1.count)
    if object_1.class == Array
      (object_1.reduce(&:+).to_f / object_2.to_f).round(2)
    else
      (object_1.to_f / object_2.to_f).round(2)
    end
  end


end
