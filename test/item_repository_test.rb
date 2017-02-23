require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository.rb'
require './lib/sales_engine'
require 'simplecov'
SimpleCov.start

class ItemRepositoryTest < Minitest::Test

  def test_it_exists2
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_instance_of ItemRepository, ir
  end

  def test_has_method_all
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_instance_of Array, ir.all
  end

  def test_find_by_id
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items
    
    assert_equal "Glitter scrabble frames", ir.find_by_id("263395617").name
    assert_nil ir.find_by_id("263355617")
  end

  def test_find_by_name
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_equal "263395617", ir.find_by_name("Glitter scrabble frames").id
    assert_nil ir.find_by_name("banana")
  end

  def test_find_all_with_description
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_equal Array, ir.find_all_with_description("glitter").class
    assert_equal [], ir.find_all_with_description("banana")
    assert_equal 2, ir.find_all_with_description("glitter").length
  end
end