module Mathable
  def sum_square_diff(set)
    set.sum do |item|
      (item - average(set))**2
    end
  end

  def average(set)
    set.sum.to_f/set.count
  end
end