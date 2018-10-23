require "./test/test_helper"

class ItemTest < Minitest::Test
  def setup
    @time = Time.now
    @item = Item.new({
              :id          => 1,
              :name        => "Pencil",
              :description => "You can use it to write things",
              :unit_price  => BigDecimal.new(10.99,4),
              :created_at  => Time.now,
              :updated_at  => Time.now,
              :merchant_id => 2
            })

  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_id
    assert_equal 1, @item.id
  end

  def test_it_has_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_has_unit_price
    assert_equal BigDecimal.new(10.99,4), @item.unit_price
  end

  def test_it_has_start_date
    assert_equal @time, @item.created_at
  end

  def test_it_has_updated_date
    assert_equal @time, @item.updated_at
  end

  def test_it_has_merchant_id
    assert_equal 2, @item.merchant_id
  end

  def test_it_converts_unit_price_to_dollars_float
    assert_equal 10.99, @item.unit_price_to_dollars
  end 

end
