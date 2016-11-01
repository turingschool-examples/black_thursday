require_relative 'test_helper'
require './lib/find_functions'
require './lib/item_repository'

class FindFunctionsTest < Minitest::Test
  include FindFunctions
  attr_reader :collection
  
  def setup
   @collection = ItemRepository.new("./data/test_items.csv").item_objects
  end

  def test_find_functions_exists_and_is_a_module
    assert Module, FindFunctions.class
  end

  def test_it_returns_an_object_that_meets_the_criteria
    input = "510+ RealPush Icon Set"
    assert_equal Item, find_by(collection, :name, input).class
  end

  def test_it_returns_nil_if_the_element_is_not_found
    input = "BetterCallSaul"
    assert_equal nil, find_by(collection, :name, input)
  end

  def test_it_finds_all_instances_of_an_element
    input = "510+ RealPush Icon Set"
    assert_equal 1, find_all(collection, :name, input).count
  end

  def test_it_returns_an_empty_array_if_none_are_found
    input = "BetterCallSaul"
    assert_equal [], find_all(collection, :name, input)
  end

  # def test_it_checks_if_attribute_is
end
