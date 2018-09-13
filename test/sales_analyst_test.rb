require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalystTest<Minitest::Test

  def setup
    @se = SalesEngine.from_csv(
                               {:items => "./test/fixtures/items.csv",
                                :merchants => "./test/fixtures/merchants.csv"}
                            )
    @sa = @se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

end
