require_relative 'test_helper'

require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    @sa = SalesAnalyst.new
  end
end
