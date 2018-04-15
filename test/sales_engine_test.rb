require './test/test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/item'


class SalesEngineTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({
  :items     => "./test/fixtures/item_fixture.csv",
  :merchants => './test/fixtures/merchant_fixture.csv'
  })
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
  end

  def test_it_can_access_merchant_data
    assert_equal 'Shopin1901', se.merchants.merchants.values.first.name
    assert_equal 12334123, se.merchants.merchants.values.last.id
    refute_equal 'spider-man', se.merchants.merchants.values.last.name
    refute se.merchants.merchants.empty?
  end

  def test_it_can_access_item_data
    assert_equal 'Box', se.items.contents.values.first.name
    assert_equal 263399185, se.items.contents.values.last.id
    refute_equal 'spider-man', se.items.contents.values.last.name
    refute se.items.contents.values.empty?
  end
  # 
  # def test_it_has_all_items
  #
  #   assert_equal 3, se.all_items
  # end
  #
  # def test_it_has_all_merchants
  #   skip
  #   assert_equal 5, se.all_merchants.count
  # end
end
