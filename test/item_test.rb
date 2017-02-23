require 'test_helper'
require '.lib/item'

class ItemTest < Minitest::Test

  def test_it_exists
    # i = Item.new({
    #   :name        => "Pencil",
    #   :description => "You can use it to write things",
    #   :unit_price  => BigDecimal.new(10.99,4),
    #   :created_at  => Time.now,
    #   :updated_at  => Time.now,})
  end

  def test_it_returns_integer_id_of_item
    # method #id
    # returns the integer id of the item
  end

  def test_it_returns_name_of_item
    # method #name
    # returns the name of the item
  end

  def test_it_returns_description_of_item
    # method #description
    # returns the description of the item
  end

  def test_it_returns_unit_price
    # method #unit_price
    # returns the price of the item formatted as a BigDecimal
  end

  def test_unit_price_is_formatted_as_bigdecimal
    # method #unit_price
    # returns the price of the item formatted as a BigDecimal
  end

  def test_it_returns_instance_of_time_for_date_item_was_first_created
    # method #created_at
    # returns a Time instance for the date the item was first created
  end

  def test_it_returns_instance_of_time_for_date_item_was_last_modified
    # method #updated_at
    # returns a Time instance for the date the item was last modified
  end

  def test_it_returns_integer_id_of_merchant_of_item
    # method #merchant_id
    # returns the integer merchant id of the item
  end
end
