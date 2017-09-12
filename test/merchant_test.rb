require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/sales_engine'


class MerchantTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
          :items     => "./data/items_fixture.csv",
          :merchants => "./data/merchants_fixture.csv",
        })
    mr = se.merchants 
  end 

  def test_it_exists
    m1 = Merchant.new({:id => 5, :name => "Turing School"}, '')

    assert_instance_of Merchant, m1
  end

  def test_it_has_an_id
    m1 = Merchant.new({:id => 5, :name => "Turing School"}, '')

    assert_equal 5, m1.id
  end

  def test_it_has_a_name
    m1 = Merchant.new({:id => 5, :name => "Turing School"},'')

    assert_equal "Turing School", m1.name
  end

  def test_merchant_has_sales_engine
    mr = setup

    assert mr.merchants[0].sales_engine

  end 
end
