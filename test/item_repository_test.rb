require_relative 'test_helper'
require './lib/item_repository'
require './lib/item'
require 'csv'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    csv_file_name = './data/items.csv'
    assert_instance_of ItemRepository, ItemRepository.new(csv_file_name)
  end

  def test_it_creates_item_objects_for_each_row
    csv_file_name = './data/items.csv'
    repository = ItemRepository.new(csv_file_name)

end
