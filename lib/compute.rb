class Compute

  def self.mean(sum, num_of_elements)
    mean = sum / num_of_elements
    mean.to_f.round(2)
  end

end
