require 'minitest/autorun'
require 'minitest/pride'
# require './lib/item_repository'
# require './lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < MiniTest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
    })
    ir = se.items
  end
  def test_it_exists
    ir = setup
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_parse_data
    ir = setup

    assert ir.items.length > 0
  end

  def test_reports_all_items_in_array
    ir = setup

    assert_equal 60, ir.all.length
  end

  def test_it_returns_item_given_the_id
    ir = setup

    assert_equal '510+ RealPush Icon Set', ir.find_by_id(263395237).name
  end

  def test_returns_item_given_the_name
    ir = setup

    assert_equal '510+ RealPush Icon Set', ir.find_by_name('510+ RealPush Icon Set').name
  end

  def test_returns_item_of_given_description
    ir = setup
        description = "Glitter scrabble frames"

    assert_equal description, ir.find_all_with_description(description)[0].description
    assert_equal [], ir.find_all_with_description('dogs')
  end

  def test_finds_all_by_price_in_range
    ir = setup

    assert_equal 2, ir.find_all_by_price_in_range(600,1300).length
  end

  def test_item_has_merchant_id
    ir = setup

    assert_equal 12334141, ir.find_by_name('510+ RealPush Icon Set')  .merchant_id
  end

  def test_repository_has_reference_to_sales_engine
    ir = setup

    assert ir.sales_engine
  end

  # def test_items_initialize_with_merchants
  #   ir = setup
  # end

end
