require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository.rb'
require './lib/sales_engine'
require 'simplecov'
SimpleCov.start

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_instance_of ItemRepository, ir
  end

  def test_has_method_all
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_instance_of Array, ir.all
  end
end