require './test/test_helper'

class ItemTest < Minitest::Test

  def setup
    @i = Item.new({
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
    assert_instance_of Item, @i
  end

  def test_it_has_id
    assert_equal 1, @i.id
  end

  def test_it_has_name
    assert_equal "Pencil", @i.name
  end

  def test_it_has_description
    assert_equal "You can use it to write things", @i.description
  end

  def test_it_has_unit_price
    assert_equal BigDecimal.new(10.99,4), @i.unit_price
    p @i.unit_price
  end

  def test_it_has_created_at
    assert_instance_of Time, @i.created_at
  end

  def test_it_has_updated_at
    assert_instance_of Time, @i.updated_at
  end

  def test_it_has_merchant_id
    assert_equal 2, @i.merchant_id
  end

  def test_it_converts_unit_price_to_dollars
    assert_equal 10.99, @i.unit_price_to_dollars
  end

end
