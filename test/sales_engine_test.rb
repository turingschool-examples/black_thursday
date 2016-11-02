require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/sales_engine'


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

  # def test_it_initializes_with_items
  #   assert @sales_engine.items
  #   assert_equal ItemRepository, @sales_engine.items.class
  # end
  #
  # def test_csv_load_works
  #   result = @sales_engine.merchants.all.first.id
  #   assert_equal 12334105, result
  # end

end
