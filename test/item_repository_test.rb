require_relative 'test_helper'
require_relative '../lib/item_repository'
require 'minitest/autorun'
require 'minitest/pride'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")

    assert_instance_of ItemRepository, ir
  end

  def test_repo_pulls_in_CSV_info_from_items
    ir = ItemRepository.new("./data/items.csv")

    assert_equal 1367, ir.from_csv("./data/items.csv").count
  end

  def test_it_returns_array_of_all_items
    ir = ItemRepository.new("./data/items.csv")

    assert_equal 1367, ir.all.count
  end





end
