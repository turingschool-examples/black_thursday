require './test/test_helper'
require 'minitest/autorun'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  attr_reader :test_helper, :item_repo

  def setup
    @test_helper = TestHelper.new.items
    @item_repo = ItemRepository.new(test_helper)
  end

  def test_it_can_hold_items
    assert_equal 3, item_repo.items.count
  end

  def test_it_can_access_name_data_from_the_items
    assert_equal "Pencil", item_repo.items[0].name
  end

  def test_it_can_access_different_name_data_from_the_items
    assert_equal "Paper", item_repo.items[2].name
  end

  def test_it_can_access_description_data_from_the_items
    assert_equal "You can use it to also write things", item_repo.items[1].description
  end

  def test_it_can_return_all_item_instances
    assert_equal 3, item_repo.all.count
  end

  def test_it_can_return_all_item_in_an_array
    assert_equal Array, item_repo.all.class
  end

  def test_it_can_return_all_item_instances_with_data
    assert_equal "Pencil, Pen, Paper", name_of_item_objects(item_repo.all)
  end

  private

  def name_of_item_objects(collection)
    collection.map do |object|
      object.name
    end.join(", ")
  end


end
