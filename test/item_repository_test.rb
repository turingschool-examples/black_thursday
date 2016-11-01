require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'
require 'pry'

class ItemRepositoryTest < Minitest::Test
    attr_reader  :repository
  def setup
    @repository = ItemRepository.new('fixture/items.csv')
  end

  def test_it_can_create_item_repository
    assert repository
  end

  def test_all_returns_instances_of_items
    skip
  end

  def test_it_can_return_instance_of_item_with_matching_id
    assert repository.find_by_id(1)
    assert_instance_of Item, repository.id(1)
    assert repository.find_by_id(2)
    assert_instance_of Item, repository.id(2)
    assert_nil repository._find_by_id(50)
  end

  def test_it_can_return_instance_of_item_if_name_matches
    assert repository.find_by_name("Pencil")
    assert repository.find_by_name("Pen")
    assert_instance_of Item, repository.find_by_name("Pencil")
    assert_instance_of Item, repository.find_by_name("Pen")
    assert_nil repository.find_by_name("Bat")
  end

  def test_name_match_is_case_insensitive
    assert repository.find_by_name("Basketball")
    assert repository.find_by_name("basketball")
    assert repository.find_by_name("BASKETBALL")
    assert repository.find_by_name("BaSkEtBaLl")
    assert repository.find_by_name("Baseball")
    assert repository.find_by_name("baseball")
    assert repository.find_by_name("BASEBALL")
    assert repository.find_by_name("BaSeBaLl")
  end

  def test_description_tests
    skip
  end

  def test_it_can_return_array_with_all_items_that_match_price
    assert repository.find_all_by_price(10)
    assert_equal 2, repository.find_all_by_price(10).length
    assert repository.find_all_by_price(40)
    assert_equal 1, repository.find_all_by_price(40)
    assert_equal
  end


end

