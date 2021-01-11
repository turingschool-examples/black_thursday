require 'bigdecimal'

module StandardDeviation
  extend self
  
  def item_mean
    (self.sum / self.length.to_f)
  end

  def sample_variance
    new_mean = self.item_mean
    new_sum = self.reduce(0) do |memo, item|
      memo + (item - new_mean.to_f) ** 2
    end

    new_sum / (self.length - 1).to_f
  end

  def standard_deviation
    Math.sqrt(self.sample_variance).round(2)
  end

end
