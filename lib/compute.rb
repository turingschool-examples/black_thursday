class Compute

  def self.mean(sum, num_of_elements)
    mean = sum.to_f / num_of_elements
    mean.round(2)
  end

end
