require "minitest/autorun"
require "minitest/pride"
require "./lib/item"
require "./lib/item_repository"
require "simplecov"
SimpleCov.start

class ItemTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items
    i = ir.all

    assert_instance_of Item, i.first
  end

  def test_id_method_returns_item_id
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items
    i = ir.all

    assert_equal "263395617", i.first.id
  end

  def test_name_method_returns_item_name
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items
    i = ir.all

    assert_equal "Glitter scrabble frames", i.first.name
  end

  def test_description_method_returns_item_description
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items
    i = ir.all

    assert_equal String, i.first.description.class
  end

  def test_unit_price_method_returns_unit_price
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items
    i = ir.all

    assert_equal "1300", i.first.unit_price
  end

  def test_created_at_returns_date_created_at
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items
    i = ir.all

    assert_equal "2016-01-11 11:51:37 UTC", i.first.created_at
  end

  def test_updated_at_returns_date_updated
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items
    i = ir.all

    assert_equal "1993-09-29 11:56:40 UTC", i.first.updated_at
  end

  def test_merchant_id_returns_merchant_id
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items
    i = ir.all

    assert_equal "12334185", i.first.merchant_id
  end

end
