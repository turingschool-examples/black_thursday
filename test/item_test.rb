require_relative 'test_helper'
require_relative '../lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    data = {
      :id          => "137519844",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => "2018-19-02 14:37:20 -0700",
      :updated_at  => "2018-19-02 14:37:20 -0700",
      :merchant_id => "12334105"
        }
    @item = Item.new(data)
  end

  def test_if_it_exists
    assert_instance_of Item, @item
  end

end
