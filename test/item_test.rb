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

  def test_unit_price_to_dollars_works_retuns_zero_cents
    item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(0),
      :merchant_id => 12334123,
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"})

  assert_equal 0, item.unit_price_to_dollars
  end

  def test_unit_price_to_dollars_returns_a_float
    assert_equal Float, @item.unit_price_to_dollars.class
  end

  def test_merchant
    skip
    merchant = Merchant.new
    item = Item.new("", merchant)
    merchant.expects(:created_at).returns("2007-06-25")
    assert_equal 'd', item.merchant
  end

  def test_downcase_returns_a_lowercase_name
    assert_equal "pencil", @item.downcaser
  end

  def test_dowcase_works_for_multiple_words
    item = Item.new({
      :name        => "aPPle saUce",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(0),
      :merchant_id => 12334123,
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"})

    assert_equal "apple sauce", item.downcaser
  end

  def test_downcase_works_for_empty_string
    item = Item.new({
      :name        => "",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(0),
      :merchant_id => 12334123,
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"})

    assert_equal "", item.downcaser
  end
end
