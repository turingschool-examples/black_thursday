require "./test/test_helper"
require "./lib/item"

class ItemTest < Minitest::Test

  attr_reader :item

  def setup
    csv_hash = {id: 1,
                name: "Pencil",
                description: "You can use it to write things",
                unit_price: BigDecimal.new(1099,4),
                created_at: "2016-01-11 09:34:06 UTC",
                updated_at: "2007-06-04 21:35:10 UTC",
                merchant_id: 2}
    @item = Item.new('fake_ir', csv_hash)
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_item_has_id
    assert_equal 1, item.id
  end

  def test_item_has_a_name
    assert_equal "Pencil", item.name
  end

  def test_item_has_a_description
    assert_equal "You can use it to write things", item.description
  end

  def test_item_has_a_unit_price
    assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  def test_item_has_created_at_time
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), item.created_at
  end

  def test_item_has_updated_at_time
    assert_equal Time.parse("2007-06-04 21:35:10 UTC"), item.updated_at
  end

  def test_item_has_merchant_id
    assert_equal 2, item.merchant_id
  end

  def test_unit_price_to_dollars_converts
    assert_equal 10.99, item.unit_price_to_dollars(BigDecimal.new(1099,4))
  end

end
