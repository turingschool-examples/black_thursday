class Compute

  def self.mean(sum, num_of_elements)
    if sum.class == BigDecimal
      mean = sum / num_of_elements
    else
      mean = sum.to_f / num_of_elements
    end
    mean.round(2)
  end

end
