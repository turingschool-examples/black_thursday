require './lib/item'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def test_it_exists
    item = Item.new({
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => BigDecimal.new(10.99,4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                  })

    assert_instance_of Item, item
  end
end
