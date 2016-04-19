require "minitest/autorun"
require "minitest/pride"
require "./lib/item_repository"

class ItemRepositoryTest < Minitest::Test

  def test_item_repository_can_exist
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    assert ir
  end

  def test_it_can_parse_a_small_csv_file
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    
  end

end
