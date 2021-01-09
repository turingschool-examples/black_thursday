require_relative './test_helper'
# require './lib/item_repository'
# require './lib/item'
require 'time'

class ItemTest < Minitest::Test

  def setup
    item_path = "./data/items.csv"
    arguments = {:items => item_path}
    @engine = SalesEngine.from_csv(arguments)
  end

  def test_it_exists
    assert_instance_of Item, @engine.items.all.first
  end

  def test_id_returns_id
    item_one = @engine.items.all.first

    assert_equal 263395237, item_one.id

    item_two = @engine.items.all.last

    assert_equal 263567474, item_two.id
  end

  def test_name_returns_name
    item_one = @engine.items.all.first

    assert_equal "510+ RealPush Icon Set", item_one.name

    item_two = @engine.items.all.last

    assert_equal "Minty Green Knit Crochet Infinity Scarf", item_two.name
  end

  def test_description_returns_description
    item_one = @engine.items.all.first
    assert_equal String, item_one.description.class
    assert_equal 2236, item_one.description.length
  end

  def test_unit_price_returns_unit_price
    item_one = @engine.items.all.first

    assert_equal 12.00, item_one.unit_price
    assert_equal BigDecimal, item_one.unit_price.class
  end

  def test_created_at_returns_time_item_was_created_at
    item_one = @engine.items.all.first
    time = Time.parse("2016-01-11 09:34:06 UTC")
    assert_equal time, item_one.created_at
  end

  def test_updated_at_returns_the_time_it_was_last_updated
    item_one = @engine.items.all.first

    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), item_one.updated_at
    assert_equal Time, item_one.updated_at.class
  end

  def test_unit_price_to_dollars_returns_price_as_float
    expected = @engine.items.find_by_id(263397059)

    assert_equal 130.0, expected.unit_price_to_dollars
    assert_equal Float, expected.unit_price_to_dollars.class
  end
end
