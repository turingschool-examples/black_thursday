require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :engine
  
  def initialize(engine)
    @engine = engine
  end
end
