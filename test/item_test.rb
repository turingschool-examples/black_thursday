require './test/test_helper'
require './lib/item'

class ItemTest < MiniTest::Test
  def setup
    @item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(1099),
      :merchant_id => 12334123,
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"})
  end

  def test_unit_price_to_dollars
    assert_equal 10.99, @item.unit_price_to_dollars
  end

  def test_merchant
    # stub something out
    skip
    merchant_1 = stub(merchant: Mocha)
    assert_equal Mocha, merchant_1.merchant
  end

  def test_downcase_returns_a_lowercase_name
    assert_equal "pencil", @item.downcaser
  end
end
