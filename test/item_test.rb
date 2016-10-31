require_relative 'test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    item_info = {:id => 5, :name => "Turing School"}
    @item = Item.new(item_info)
  end

  def test_it_exists
    assert @item
  end

  def test_it_initializes_item_id
    assert_equal 5, @item.id
  end

  def test_it_initializes_item_name
    assert_equal "Turing School", @item.name
  end

  def test_it_checks_if_item_id_is_not_integer
    item_info = {:id => "yes", :name => "Turing School"}
    refute @item.item_info_clean?(item_info)
  end

  def test_it_checks_if_item_name_is_not_string
    item_info = {:id => 5, :name => :turing_school}
    refute @item.item_info_clean?(item_info)
  end

  def test_it_checks_if_item_info_is_nil
    item_info = {:id => nil, :name => nil}
    refute @item.item_info_clean?(item_info)
  end

  def test_initialize_returns_argument_error_if_item_info_not_clean
    item_info = {:id => "y", :name => "Turing School"}
    assert_raises(ArgumentError) {Item.new(item_info)}
  end

  def test_error_message_explains_problem
    string = "Error: :id must be a number and :name must be a string."
    assert_equal string, @item.error
  end

end
