require_relative './test_helper'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  def setup
    # item_path = "./data/items.csv"
    # arguments = {:items => item_path}
    @ir = ItemRepository.new("./data/items.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_all_displays_all_items
    assert_equal 1367, @ir.all
  end

  def test_find_by_id_finds_an_item_by_id
    result_1 = @ir.find_by_id(263538760)

    assert_equal 263538760, result_1.id.to_i
    assert_equal "Puppy blankie", result_1.name

    result_2 = @ir.find_by_id(1)

    assert_nil nil, result_2
  end

  def test_find_by_name_finds_an_item_by_name
    result_1 = @ir.find_by_name("Puppy blankie")

    assert_equal "Puppy blankie", result_1.name
    assert_equal 263538760, result_1.id.to_i

    result_2 = @ir.find_by_name("Sales Engine")

    assert_nil nil, result_2
  end
end
