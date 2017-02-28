module Functions

  def find_average(data)
    (data.reduce(:+) / data.length.to_f)
  end

	def validate_number(data)
    return data.length unless data.nil?
    0
	end

  def standard_deviation(data, average, total)
    Math.sqrt(add_squared(data, average) / (total - 1)).round(2)
  end
  
	def add_squared(data, average)
    data.reduce(0) do |result, number|
      result += ((number - average) ** 2)
      result
    end
	end

	def above_standard_deviation(average, deviation, amount = 1)
    average + (deviation * amount)
	end

  def below_standard_deviation(average, deviation, amount = 1)
    average - (deviation * amount)
  end

	def split_invoices_by_creation_date
    se.invoices.all.reduce(Array.new(7,0)) do |result, invoice|
      result[invoice.created_at.wday] += 1
      result
    end
	end
end