require './test/test_helper'

class ItemTest < Minitest::Test

  def setup
    @t = Time.now
    @i = Item.new({
	  :id          => 1,
	  :name        => "Pencil",
	  :description => "You can use it to write things",
	  :unit_price  => BigDecimal.new(10.99,4),
	  :created_at  => @t,
	  :updated_at  => @t,
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
    skip
    assert_equal "Pencil", @i.name
  end

  def test_it_has_description
    skip
    assert_equal "You can use it to write things", @i.description
  end

  def test_it_has_unit_price
    skip
    assert_equal BigDecimal.new(10.99,4), @i.unit_price
  end

  def test_it_has_created_at
    skip
    p "Verify current time of #{@t}"
    assert_equal @t, @i.created_at
  end

  def test_it_has_updated_at
    skip
    assert_equal @t, @i.updated_at
  end

  def test_it_has_merchant_id
    skip
    assert_equal 2, @i.merchant_id
  end

end
