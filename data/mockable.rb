require 'Date'

module Mockable
  extend self

  def created_at_proc
    return Proc.new { |date| next date.next_year }
  end

  def updated_at_proc
    return Proc.new { |date| next date }
  end

  def generator(number_of_hashes)
    (0...number_of_hashes).to_a
  end

  def mock_generator(eg, mock_name, data_hashes)
    data_hashes.each_with_object([]) do |hash, mocks|
      mocks << eg.instance_double(mock_name, hash)
    end
  end

  def sum_item_prices_from_hash(items)
    items.sum do |item|
      item[:unit_price]
    end
  end

  def mean_of_item_prices_from_hash(items)
    sum = sum_item_prices_from_hash(items)
    (sum / items.length)
  end

  def date_format
    /\d{4}-\d{2}-\d{2}/
  end

  def get_a_random_date(random = true)
    if random
      date_s = "20#{rand(10..21)}-#{rand(1..12)}-#{rand(1..28)}"
      return Date.strptime(date_s, '%Y-%m-%d')
    else
      return Date.strptime('2020-01-01', '%Y-%m-%d')
    end
  end

  def get_a_random_quantity
    rand(1..20)
  end

  def get_a_random_price
    (rand(1..100) + (rand(100) / 100.0))
  end
end
