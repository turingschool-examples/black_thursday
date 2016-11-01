require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/sales_engine'


class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new({
    :items     => 'data/item_fixture.csv',
    :merchants => 'data/merchants_fixture.csv',
    })
  end

  def test_it_exists
    assert @sales_engine
    assert_equal SalesEngine, @sales_engine.class
  end

  def test_it_initializes_with_merchants
    assert @sales_engine.merchants
    assert_equal MerchantRepository, @sales_engine.merchants.class
  end

  def test_it_initializes_with_items
    assert @sales_engine.items
    assert_equal ItemRepository, @sales_engine.items.class
  end

  def test_csv_load_works
    result = @sales_engine.merchants.all.first.id
    assert_equal 12334105, result
  end

end
