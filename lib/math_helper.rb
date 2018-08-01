# frozen_string_literal: true

# ./lib/math_helper.rb
module MathHelper
  def get_squared_values(grouped_hash, average)
    grouped_hash.map do |_id, item|
      (item.count - average)**2
    end
  end

  def get_total_of_squares(grouped_hash, average)
    get_squared_values(grouped_hash, average).inject(0) do |sum, value|
      sum + value
    end
  end

  def get_mean_of_totaled_squares(grouped_hash, average)
    total_of_squares = get_total_of_squares(grouped_hash, average)
    squared_values = get_squared_values(grouped_hash, average).count
    total_of_squares / squared_values
  end

  def final_square(mean_total_sqr, mean_items_per)
    Math.sqrt(
      get_mean_of_totaled_squares(mean_total_sqr, mean_items_per)
    ).round(2)
  end
end
