require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require 'csv'
require 'pry'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                                                                  })
  end
  def test_it_can_be_initialized
    se = SalesEngine.new
    assert se
    assert_instance_of SalesEngine, se
  end

  def test_class_method_working
    se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                                                                  })
    assert_instance_of SalesEngine, se
    assert se
  end

  def test_class_method_integration_merch_repo
    found_1    = @se.merchants.find_by_name("MyouBijou")
    found_2    = @se.merchants.find_by_id("12335252")
    found_list_one = @se.merchants.find_all_by_name("liv")
    found_list_two = @se.merchants.find_all_by_name("ba")

    assert_equal "MyouBijou"  , found_1.name
    assert_equal "12334455"   , found_1.id
    assert_equal "habichschon", found_2.name
    assert_equal "12335252"   , found_2.id
    assert_equal 4            , found_list_one.count
    assert_equal 15           , found_list_two.count
  end


  def test_class_method_integration_item_repo
    found_1    = @se.items.find_by_name("510+ RealPush Icon Set")
    found_2    = @se.items.find_by_id(263396013)

    assert_equal "510+ RealPush Icon Set"     , found_1.name
    assert_equal 263395237                    , found_1.id
    assert_equal "Free standing Woden letters", found_2.name
    assert_equal 263396013                    , found_2.id
  end

  def test_find_all_with_descrip_or_merch_id_work_integration
    found_list_one = @se.items.find_all_with_description("liv")
    found_list_two = @se.items.find_all_by_merchant_id(12334185)

    assert_equal 94, found_list_one.count
    assert_equal 6, found_list_two.count
  end

  def test_find_all_by_price_and_price_range_integration
    found_list_one = @se.items.find_all_by_price(700)
    found_list_two = @se.items.find_all_by_price_in_range(500, 600)

    assert_equal 10, found_list_one.count
    assert_equal 59, found_list_two.count
  end
end
