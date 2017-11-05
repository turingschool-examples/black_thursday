module Statistics
  def averager(object_count, by_object_count)
    (object_count.to_f / by_object_count).round(2)
  end

  def standard_deviation(population, object, by_object)
    average = averager(object, by_object)
    Math.sqrt(population.map do |sub_count|
      (average - sub_count) ** 2
    end.sum / (by_object - 1 )).round(2)
  end

end
