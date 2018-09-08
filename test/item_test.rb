require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    input = {
      :id => 1, 
      :name => "Pencil",
      :description => "You can use it to write things",
      :unitt_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now,
      :merchant_id => 2
    }
    @m = Item.new(input)
  end

  def test_it_exists
    assert_instance_of Item, @m
  end

  def test_it_has_attributes
    assert_equal 1, @m.id
    assert_equal "Pencil", @m.name
  end


end