ar = [1, 2, 3, 4]

def mean(array)

  ar_sum = array.inject(0) do |things, stuff|
    things + stuff
  end

  avg = ar_sum.to_f / array.length

end

def sum(array)
  array.inject(0) do |things, stuff|
    things + stuff
  end
end


p standard_deviation(ar)
