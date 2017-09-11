require_relative 'test_helper'
require './lib/item_repository'
require './lib/item'
require 'csv'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    csv_file_name = './data/items.csv'
    assert_instance_of ItemRepository, ItemRepository.new(csv_file_name)
  end
end
