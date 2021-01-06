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

    result = @ir.find_by_id(263538760)
    require "pry"; binding.pry

    assert_equal 263538760, result.id
          #
          #
          # expect(expected.id).to eq id
          # expect(expected.name).to eq "Puppy blankie"
          #
          #
          #
          #
          # id = 1
          # expected = engine.items.find_by_id(id)
          #
          # expect(expected).to eq nil
  end
end
