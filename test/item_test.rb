require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'pry'
require './lib/item'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({
      :name         => "Pencil",
      :description  => "You can use it to write things",
      :unit_price   => BigDecimal.new(10.99,4),
      :created_at   => Time.now,
      :updated_at   => Time.now
      })
  end


  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_a_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_returns_item_price_as_bigdecimal
    assert_equal "You can use it to write things", @item.description
  end

end
