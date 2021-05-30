module Mathable

  def average(hash)
    number_of_keys = hash.keys.count
    total_records = hash.values.sum.to_f
    (total_records / number_of_keys)
  end

  def hash_variance_from_mean(hash)
    hash.each_with_object({}) do |original_hash, modified_hash|
      modified_hash[original_hash.first] = (original_hash.last - average(hash)) ** 2
    end
  end

  def standard_deviation(hash)
    modified_hash = hash_variance_from_mean(hash)
    divisor = hash.keys.count - 1
    sum = modified_hash.values.sum
    Math.sqrt(sum / divisor).round(2)
  end
end
