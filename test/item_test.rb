require './test/test_helper'
require 'minitest/autorun'
require './lib/item'

class ItemTest < Minitest::Test

  attr_reader :i

  def setup
    @i = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => "2016-04-19 09:04:25 -0600",
      :updated_at  => "2016-04-19 09:04:25 -0600",
    })
  end

  def test_it_can_return_a_name
    assert_equal "Pencil", i.name
  end

  def test_it_can_return_a_description
    assert_equal "You can use it to write things", i.description
  end

  def test_it_can_return_a_unit_price
    #figure out how big decimal works
    skip
    assert_equal "", i.unit_price
  end

  def test_it_can_return_when_it_was_created
    #need to figure out how to format time.
    assert_equal "2016-04-19 09:04:25 -0600", i.created_at
  end

  def test_it_can_return_when_it_was_updated
    #need to figure out how to format time.
    assert_equal "2016-04-19 09:04:25 -0600", i.updated_at
  end

end
