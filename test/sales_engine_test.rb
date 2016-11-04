require 'minitest/autorun'
require 'minitest/emoji'
require 'csv'
require 'bigdecimal'
require './lib/sales_engine'


class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:items => "./data/small_item_file.csv",
      :merchants => "./data/small_merchant_file.csv"})
    assert_equal Class, SalesEngine.class
  end

  def test_it_has_its_own_class
    assert SalesEngine, SalesEngine.class
  end

  def test_it_can_instantiate_merchant_repo
    se = SalesEngine.from_csv({:items => "./data/small_item_file.csv",
      :merchants => "./data/small_item_file.csv"})
    assert_equal MerchantRepo, se.merchant_repo.class
  end

  def test_it_can_instantiate_item_repo
    se = SalesEngine.from_csv({:items => "./data/small_item_file.csv",
      :merchants => "./data/small_item_file.csv"})
    assert_equal ItemRepo, se.item_repo.class
  end
end