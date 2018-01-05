require './test/test_helper'
require './lib/item'

class ItemTest < MiniTest::Test
  def setup
    @item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(1099),
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"})
  end

  def test_unit_price_to_dollars
    assert_equal 10.99, @item.unit_price_to_dollars
  end
end
