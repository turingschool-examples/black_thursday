require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repository'

class SalesEngineTest < Minitest::Test

  def test_existence_of_sales_class
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end

  def test_from_csv
    se = SalesEngine.new
    se.from_csv({:merchants => "./data/merchants.csv"})

    assert_instance_of MerchantRepository, se.merchants
  end


end
