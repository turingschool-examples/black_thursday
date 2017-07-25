require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require 'csv'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_it_can_parse
    skip
    se = SalesEngine.new
    se.load_csv("./data/merchants_short.csv", :merchants)
    assert_equal 5, se.merchants.merchants.count
  end

  def test_class_method_working
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                                                                  })
    # assert_instance_of ItemRepository, se.items
    assert_instance_of SalesEngine, se
  end

  def test_class_method_integration_merch_repo
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                                                                  })
    found_1 = se.merchants.find_by_name("MyouBijou")
    found_2 = se.merchants.find_by_id("habichschon")

    assert_equal "MyouBijou", found_1.name
    assert_equal "12334455" , found_1.id
    assert_equal
    assert_equal "12335252"
  end
  def test_class_method_integration_merch_repo
  end
end
