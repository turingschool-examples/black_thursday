require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def test_it_exist
    sales_analyst = SalesAnalyst.new

    assert_instance_of SalesAnalyst, sales_analyst
  end

end
