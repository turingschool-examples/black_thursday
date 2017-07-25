require_relative 'test_helper'
require './lib/item_repository'
require 'pry'

class ItemRepositoryTest < Minitest::Test

  def test_it_exitst
    ir = ItemRepository.new("./data/mini_items.csv")
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_load_csv_file
    ir = ItemRepository.new("./data/items.csv")
    assert ir
  end
end
