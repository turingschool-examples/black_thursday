require_relative './sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.all_items.length.fdiv(@sales_engine.all_merchants.length).round(2)
  end

  def number_items_per_merchant
    @sales_engine.all_merchants.map do |merchant|
      @sales_engine.items.find_all_by_merchant_id(merchant.id).count
    end
  end

  def avg(data)
    data.sum.fdiv(data.count)
  end

  def std_dev(data)
    numerator = data.reduce(0) do |sum, num|
      sum + (num - avg(data))**2
    end
    Math.sqrt(numerator/(data.count - 1)).round(2)
  end
  #why the -1 ??? 

# Ian, can we use this?  
  def average_items_per_merchant_standard_deviation
    std_dev(self.number_items_per_merchant).round(2)
  end
end
