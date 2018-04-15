require './test/test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/item'


class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({
  :items     => "./test/fixtures/item_fixture.csv",
  :merchants => './test/fixtures/merchant_fixture.csv'
  })
    assert_instance_of SalesEngine, se
  end

  def test_it_can_access_merchant_data
    se = SalesEngine.from_csv({
  :items     => "./test/fixtures/item_fixture.csv",
  :merchants => './test/fixtures/merchant_fixture.csv'
  })
    assert_equal 'Shopin1901', se.merchants.merchants.values.first.name
    assert_equal 12334123, se.merchants.merchants.values.last.id
    refute_equal 'spider-man', se.merchants.merchants.values.last.name
    refute se.merchants.merchants.empty?
  end

  def test_it_can_access_item_data

    se = SalesEngine.from_csv({
  :items     => "./test/fixtures/item_fixture.csv",
  :merchants => './test/fixtures/merchant_fixture.csv'
  })
    assert_equal 'Box', se.items.contents.values.first.name
    assert_equal 263399185, se.items.contents.values.last.id
    refute_equal 'spider-man', se.items.contents.values.last.name
    refute se.items.contents.values.empty?
  end
end
