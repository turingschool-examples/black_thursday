gem 'minitest'
require 'minitest/autorun'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_exists
    se = SalesEngine.new("data/merchants.csv")
    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_can_read_file
    se = SalesEngine.new("data/merchants.csv")
    merchants = se.merchant_data
    assert_instance_of CSV, merchants
  end

  def test_se_merchant_method
    se = SalesEngine.new("data/merchants.csv")
    assert_instance_of CSV, se.merchants
  end

  def test_se_initializes_merchant_repo
    se = SalesEngine.new("data/merchants.csv")
    mr = se.merchant_repo
    assert_instance_of MerchantRepository, mr
  end
end
