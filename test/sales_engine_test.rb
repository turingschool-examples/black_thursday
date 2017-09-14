require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'

class SalesEngineTest < Minitest::Test
  def setup
    sales = SalesEngine
    files = ({:items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    sales.from_csv(files)
  end

  def test_it_exists
    sales = SalesEngine.new([], [])

    assert_instance_of SalesEngine, sales
  end

  def test_from_csv_item
    assert_instance_of ItemRepository, setup.items
  end

  def test_from_csv_merchants
    assert_instance_of MerchantRepository, setup.merchants
  end

  def test_merchant_finds_one_specific_id
    actual = setup.merchant_items(12334105)
    assert_equal 1, actual.count
  end
  #
  # def test_item_finds_specific_id
  #   skip
  #   sales = SalesEngine
  #
  # end

end
