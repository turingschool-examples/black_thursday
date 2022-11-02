require relative
class SalesAnalyst < SalesEngine
  attr_reader :sales_analyst
  def initialize
    @sales_analyst = sales_engine.analyst
  end
end
