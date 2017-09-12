require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'bigdecimal'
require './lib/sales_engine'

class ItemTest < Minitest::Test

  def setup

    se = SalesEngine.from_csv({
          :items     => "./data/items_fixture.csv",
          :merchants => "./data/merchants_fixture.csv",
        })
    ir = se.items

  end

  def test_it_exists
    ir = setup
    assert_instance_of Item, ir.items[0]
  end

  def test_it_displays_id
    ir = setup

    assert_equal 263395237, ir.items[0].id
  end

  def test_it_has_a_name
    ir = setup

    assert_equal "510+ RealPush Icon Set", ir.items[0].name
  end

  def test_it_has_a_description
    ir = setup

    description = 'Free standing wooden letters

15cm

Any colours'

    assert_equal description, ir.items[3].description
  end

  def test_it_has_a_unit_price
    ir = setup

    assert_equal 700, ir.items[3].unit_price
  end

  def test_it_has_a_created_at_time
    ir = setup

    assert_equal "2016-01-11 11:51:36 UTC", ir.items[3].created_at
  end

  def test_it_has_an_updated_at_time
    ir = setup

    assert_equal "2001-09-17 15:28:43 UTC", ir.items[3].updated_at
  end

  def test_it_has_a_merchant_id
    ir = setup

    assert_equal 12334185, ir.items[3].merchant_id
  end

  def test_it_can_be_assigned_a_merchant
    ir = setup

    item = ir.find_by_id(263395237)
    item.gather_merchant(item.merchant_id)

    assert_equal 12334141, item.merchant.id
    assert_equal 'jejum', item.merchant.name
  end

end
