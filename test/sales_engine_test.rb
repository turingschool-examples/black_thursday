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
    assert_equal "Shopin1901", se.merchants.contents.first.name
    assert_equal "12334123", se.merchants.contents.last.id
    refute_equal "emmie", se.merchants.contents.last.name
    refute se.merchants.contents.empty?
  end

  def test_it_can_access_item_data
    se = SalesEngine.from_csv({
  :items     => "./test/fixtures/item_fixture.csv",
  :merchants => './test/fixtures/merchant_fixture.csv'
  })
    assert_equal "Box", se.items.contents.first.name
    assert_equal "263399185", se.items.contents.last.id
    refute_equal "emmie", se.items.contents.last.name
    refute se.items.contents.empty?
  end


end
