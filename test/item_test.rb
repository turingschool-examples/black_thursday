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

end
