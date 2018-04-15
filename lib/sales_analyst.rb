require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :parent

  def initialize(parent)
    @parent = parent
  end
end
