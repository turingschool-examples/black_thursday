require_relative 'test_helper'
require_relative "../lib/sales_engine"



class SalesEngineTest < Minitest::Test

  CSV_FILES = {
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
  }

  def test_it_exists
    se = SalesEngine.new(CSV_FILES)

    assert_instance_of SalesEngine, se
  end

  def test_it_initializes_new_items
    se = SalesEngine.new(CSV_FILES)

    assert_instance_of ItemRepository, se.item_repository
  end

  def test_it_initializes_new_merchants\
    se = SalesEngine.new(CSV_FILES)

    assert_instance_of MerchantRepository, se.merchant_repository
  end

end
