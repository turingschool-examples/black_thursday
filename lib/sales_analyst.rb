require_relative 'sales_analyst'

class SalesAnalyst
  attr_reader :se
  
  def initialize(se)
    @se = se
  end
end
