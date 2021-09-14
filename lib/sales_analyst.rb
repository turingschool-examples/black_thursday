require 'csv'

class SalesAnalyst

  attr_reader :sales_engine

  def initialize#(sales_engine)
    # @sales_engine = sales_engine
  end

  def purple
    puts @sales_engine
# require 'pry'; binding.pry
  end

end
