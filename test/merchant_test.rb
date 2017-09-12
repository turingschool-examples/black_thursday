require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/sales_engine'


class MerchantTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
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

  def test_it_can_gather_items
    mr = setup

    merchant1 = mr.find_by_id(12334112)
    merchant1_items = merchant1.gather_items(merchant1.id)

    merchant2 = mr.find_by_id(12334195)
    merchant2_items = merchant2.gather_items(merchant2.id)

    assert_equal 1, merchant1_items.count
    assert_equal 20, merchant2_items.count
  end

end
