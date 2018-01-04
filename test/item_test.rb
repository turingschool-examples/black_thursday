require_relative "test_helper"
require_relative "../lib/item"

class ItemTest < Minitest::Test

  def test_it_exists
    i = Item.new({id: 263443617, name: "flower brooch, pearl brooch, bulk cheap brooches, wholesale brooches, silver brooches, set of 3", description: "size: 4&quot;
    Highest quality brooches!
    Color: as shown
    Thank you for shopping!", unit_price: 4970, created_at: "2016-01-11 18:52:46 UTC", updated_at: "1984-08-01 21:04:51 UTC", merchant_id: 100}, parent = nil)

    assert_instance_of Item, i
  end

  def test_it_has_attributes
    i = Item.new({id: 263443617, name: "flower brooch, pearl brooch, bulk cheap brooches, wholesale brooches, silver brooches, set of 3", description: "size: 4&quot;
    Highest quality brooches!
    Color: as shown
    Thank you for shopping!", unit_price: 4970, created_at: "2016-01-11 18:52:46 UTC", updated_at: "1984-08-01 21:04:51 UTC", merchant_id: 100}, parent = nil)

    assert_equal 263443617, i.id
    assert_equal "flower brooch, pearl brooch, bulk cheap brooches, wholesale brooches, silver brooches, set of 3", i.name
    assert_equal "size: 4&quot;
    Highest quality brooches!
    Color: as shown
    Thank you for shopping!", i.description
    assert_equal 0.497e2, i.unit_price
    assert_instance_of BigDecimal, i.unit_price
    assert_instance_of Time, i.created_at
    assert_instance_of Time, i.updated_at
    assert_equal 100, i.merchant_id
    assert_nil i.parent
  end

  def test_unit_price_to_dollars_displays_price_as_float
    i = Item.new({id: 263443617, name: "flower brooch, pearl brooch, bulk cheap brooches, wholesale brooches, silver brooches, set of 3", description: "size: 4&quot;
    Highest quality brooches!
    Color: as shown
    Thank you for shopping!", unit_price: 4970, created_at: "2016-01-11 18:52:46 UTC", updated_at: "1984-08-01 21:04:51 UTC", merchant_id: 100}, parent = nil)

    assert_instance_of Float, i.unit_price_to_dollars
    assert_equal 49.7, i.unit_price_to_dollars
  end
end
