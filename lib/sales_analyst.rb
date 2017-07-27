require_relative 'sales_analyst'
require_relative 'stats'

class SalesAnalyst
  include Stats
  attr_reader :se

  def initialize(se)
    @se = se
  end
end
