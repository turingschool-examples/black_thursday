require_relative './test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_analyst = SalesAnalyst.new
  end

  def test_it_exists_and_has_attributes
    assert_instance_of SalesAnalyst, @sales_analyst
  end
end
