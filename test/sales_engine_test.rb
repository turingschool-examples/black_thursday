require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_existence_of_sales_class
    assert_instance_of SalesEngine, SalesEngine.new
  end

  def test_from_csv_
    se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv"
      })
    
    assert_instance_of MerchantRepository, se.merchants
  end

end