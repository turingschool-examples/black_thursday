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

  def test_it_can_find_an_item_id_and_return_that_item
    assert_equal 263410303, item_repo.find_by_id(263410303).id
  end

  def test_it_can_find_an_a_different_item_id_and_return_that_item
    assert_equal 123456789, item_repo.find_by_id(123456789).id
  end

  def test_it_returns_nil_if_id_is_not_found
    assert_equal nil, item_repo.find_by_id(7)
  end

  def test_it_can_find_an_item_by_its_name
    assert_equal "Pencil", item_repo.find_by_name("Pencil").name
  end

  def test_it_can_find_a_different_item_by_its_name
    assert_equal "Paper", item_repo.find_by_name("Paper").name
  end

  def test_it_returns_nil_if_name_is_not_found
    assert_equal nil, item_repo.find_by_name("Eraser")
  end

  def test_it_finds_all_instances_of_an_object_with_a_matching_description
    assert_equal "Pencil, Paper", name_of_item_objects(item_repo.find_all_with_description("to write"))
  end

  def test_find_all_with_description_is_case_insensitive
    assert_equal "Pencil, Paper", name_of_item_objects(item_repo.find_all_with_description("TO write"))
  end

  def test_it_returns_an_empty_array_if_description_does_not_match
    assert_equal [], item_repo.find_all_with_description("hello")
  end

  private

  def name_of_item_objects(collection)
    collection.map do |object|
      object.name
    end.join(", ")
  end


end
