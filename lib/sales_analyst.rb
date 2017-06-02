require_relative './sales_engine'

class SalesAnalyst

  attr_reader :se
  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    mr = se.merchants.all
    ir = se.items.all

    average = (ir.length.to_f)/(mr.length)
    average.round(2)
  end

  def create_items_per_merchant_hash
    merchant_items = {}

    mr = se.merchants.all

    mr.each_with_index do |merchant, idx|
      items = se.items_by_merchant_id(merchant.id)
      merchant_items[idx] = items.length
    end
    merchant_items
  end

  def average_items_per_merchant_standard_deviation
    keys = create_items_per_merchant_hash.keys
    values = create_items_per_merchant_hash.values

    mean = values.reduce(:+)/values.length

    mean_squared = values.reduce(0) { |acc, num| acc += ((num - mean)**2) }
    # binding.pry
    Math.sqrt(mean_squared / (values.length - 1))
  end
end
