require_relative 'sales_engine'
class SalesAnalyst
  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.length.to_f / engine.merchants.all.length).round(2)

  end

  def average_items_per_merchant_standard_deviation
    merchant_sample = []
    require 'pry'; binding.pry
    3.times engine.merchants.sample
      require 'pry'; binding.pry
    std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )
  end
end
