require_relative '../test/test_helper'
require_relative '../lib/sales_engine'


class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
              :items     => 'fixture/item_fixture_2.csv',
              :merchants => 'data/merchants_fixture.csv',})
  end

  def test_from_csv_instatiates_sales_engine
    result = se.items
    result2 = se.merchants
    assert result
    assert result2
    assert_equal ItemRepository, result.class
    assert_equal MerchantRepository, result2.class
  end

  def test_it_exists
    assert se
    assert_equal SalesEngine, se.class
  end

  def test_it_initializes_with_merchants
    assert se.merchants
    assert_equal MerchantRepository, se.merchants.class
  end

  def test_it_creates_a_hash_of_item_instances
    se.load_items
    assert_equal Hash, se.load_items.class
  end

  def test_it_loads_items_into_a_hash
    result = se.load_items
    assert_equal [12334113, 12334185], result.keys
  end

  def test_it_initializes_with_items
    result = se.items
    assert_equal "Custom Hand Made Miniature Bicycle", result.all.first.name
    assert_equal 263400121, result.all.first.id
  end

  def test_csv_load_works
    result = se.merchants.all.first
    assert_equal 12334105, result.id
    assert_equal "Shopin1901", result.name
  end

end
