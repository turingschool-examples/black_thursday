require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists_and_has_attributes
    parent = Minitest::Mock.new
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of ItemRepository, ir
    assert_equal "./data/items.csv", ir.path
  end

  def test_it_read_items
      parent = Minitest::Mock.new
      ir = ItemRepository.new("./data/items.csv")
      assert_equal 1367, ir.items.count
    end

  def test_case_name
    parent = Minitest::Mock.new
    ir = ItemRepository.new("./data/items.csv")
    assert_equal 1367, ir.all.count
  end

  def test_find_by_id_returns_an_instance_of_item
    parent = Minitest::Mock.new
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of Item, ir.find_by_id(263399037)
    assert_equal "Green Footed Ceramic Bowl", ir.find_by_id(263399037).name
  end


end
