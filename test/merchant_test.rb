require "minitest/autorun"
require "minitest/pride"
require "./lib/merchant"
require "./lib/sales_engine"
require "simplecov"
SimpleCov.start

require 'pry'

class MerchantTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
    assert_instance_of Merchant, m.first
  end

  def test_id_method_returns_id
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
    assert_equal "12334105", m.first.id
  end

  def test_name_method_returns_name
    se = SalesEngine.from_csv({:merchants => './test/fixtures/merchants_three.csv'})
    mr = se.merchants
    m = mr.all
    assert_equal "Shopin1901", m.first.name
  end

end

