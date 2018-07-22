require_relative '../test/test_helper.rb'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.new
  end
end
