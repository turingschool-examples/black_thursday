require './test/test_helper'
require './lib/item'

class ItemTest < Minitest::Test

  def test_it_exists
    item = Item.new(1, "Bill", "An item", "1200", "2016-01-11 09:34:06 UTC",
                   "2016-01-11 09:34:06 UTC", 123, self)

    assert_instance_of Item, item
  end

  def test_it_has_an_id
    item = Item.new(1, "Bill", "An item", "1200", "2016-01-11 09:34:06 UTC", "2016-01-11 09:34:06 UTC", 123, self)

    assert_equal 1, item.id
  end

  def test_it_has_a_name
    item = Item.new(1, "Bill", "An item", "1200", "2016-01-11 09:34:06 UTC", "2016-01-11 09:34:06 UTC", 123, self)

    assert_equal "Bill", item.name
  end

  def test_it_has_a_description
    item = Item.new(1, "Bill", "An item", "1200", "2016-01-11 09:34:06 UTC", "2016-01-11 09:34:06 UTC", 123, self)

    assert_equal "An item", item.description
  end

  def test_it_has_a_unit_price
    item = Item.new(1, "Bill", "An item", "1200", "2016-01-11 09:34:06 UTC", "2016-01-11 09:34:06 UTC", 123, self)

    assert_equal 12.00, item.unit_price
  end

  def test_it_knows_when_created
    item = Item.new(1, "Bill", "An item", "1200", "2016-01-11 09:34:06 UTC", "2016-01-11 09:34:06 UTC", 123, self)

    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), item.created_at
  end

  def test_it_knows_when_updated
    item = Item.new(1, "Bill", "An item", "1200", "2016-01-11 09:34:06 UTC", "2016-01-11 09:34:06 UTC", 123, self)

    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), item.updated_at
  end

  def test_it_has_a_merchant_id
    item = Item.new(1, "Bill", "An item", "1200", "2016-01-11 09:34:06 UTC", "2016-01-11 09:34:06 UTC", 123, self)

    assert_equal 123, item.merchant_id
  end

  def test_it_can_convert_price
    item = Item.new(1, "Bill", "An item", "1200", "2016-01-11 09:34:06 UTC", "2016-01-11 09:34:06 UTC", 123, self)
    item_2 = Item.new(2, "Bill", "An item", "902", "2016-01-11 09:34:06 UTC", "2016-01-11 09:34:06 UTC", 123, self)

    assert_equal 12.00, item.unit_price_to_dollars
    assert_equal 9.02, item_2.unit_price_to_dollars
  end

end