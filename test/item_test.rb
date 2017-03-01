require './test/test_helper'
require './lib/item'
require './lib/sales_engine'

class ItemTest < Minitest::Test
  include SalesEngineTestSetup

  def setup
    super
    @i = Item.new({
      :id          => 1111,
      :merchant_id => 222222,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => "2017-02-24 15:24:17 -0700",
      :updated_at  => "2017-02-24 15:24:17 -0700"
      })
  end

  def test_item_exists
      assert_equal "Pencil", @i.name
      assert_equal "You can use it to write things", @i.description
      assert @i.created_at
      assert @i.updated_at
      assert_equal 0.1099e0, @i.unit_price
  end

  def test_item_id
      assert_equal 1111, @i.id
  end

  def test_item_name
      assert_equal "Pencil", @i.name
  end

  def test_item_description
      assert_equal "You can use it to write things", @i.description
  end

  def test_item_unit_price
    assert_equal 0.1099e0, @i.unit_price
  end

  def test_time_stamps
    assert_instance_of Time, @i.created_at
    assert_instance_of Time, @i.updated_at
  end

  def test_unit_price_to_dollars
    float = 0.1099e0
    assert_equal float, @i.unit_price_to_dollars
  end

  def test_merchant_id
    assert_equal 222222, @i.merchant_id
  end

  def test_merchant
    item = @se.items.find_all_by_merchant_id(12334141).first
    assert_instance_of Merchant, item.merchant
    assert_equal "jejum", item.merchant.name
  end

end
