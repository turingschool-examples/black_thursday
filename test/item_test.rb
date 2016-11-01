require './test/test_helper'
require './lib/item'


class ItemTest < Minitest::Test
  attr_reader :item
  def setup
    @item = Item.new({:id => "4",
                      :name => "Thing",
                      :description => "description of the thing",
                      :unit_price => "1200",
                      :merchant_id => "01",
                      :created_at => "2016-01-11 18:30:35 UTC",
                      :updated_at => "2016-01-11 18:30:35 UTC"
                      })
  end

  def test_it_exists
    assert item
  end

  def test_it_has_id
    assert item.id
  end

  def test_it_has_name
    assert item.name
  end

  def test_it_has_description
    assert item.description
  end

  def test_it_has_unit_price
    assert item.unit_price
  end

  def test_it_has_merchant_id
    assert item.merchant_id
  end

  def test_it_has_created_at_time
    assert item.created_at
  end

  def test_it_has_updated_at
    assert item.updated_at
  end

  def test_it_can_return_an_id
    result = Item.new({:id => "14", :unit_price => "2200"})
    assert_equal 14, result.id
  end

  def test_it_can_return_a_name
    result = Item.new({:name => "Drew", :unit_price => "1400"})
    assert_equal "Drew", result.name
  end

  def test_it_can_return_a_description
    result = Item.new({:description => "It's great!", :unit_price => "2200"})
    assert_equal "It's great!", result.description
  end

  def test_it_can_return_a_price_as_a_float
    result = Item.new({:unit_price => "1400"})
    assert_equal 14.00, result.unit_price_to_dollars(BigDecimal.new("1400"))
    assert_equal 280.00, result.unit_price_to_dollars(BigDecimal.new("28000"))
  end

  def test_it_can_return_the_merchants_id
    result = Item.new({:merchant_id => "444014", :unit_price => "2400"})
    assert_equal 444014, result.merchant_id
  end

  def test_find_unit_price
    assert_equal BigDecimal, item.find_unit_price("1200").class
  end

  def test_it_turns_into_a_float
    assert_equal Float, item.unit_price_to_dollars("1200").class
  end

  def test_it_returns_a_number_at_the_end
    result = BigDecimal.new("1200")
    assert_equal Float, item.unit_price_to_dollars(result).class
  end

  def test_it_converts_a_string_into_the_time
    assert_equal Time.parse("2016-01-11 18:30:35 UTC"), item.created_at
  end

  def test_it_can_return_any_string_of_time_as_time_for_created_at
    result = Item.new({:created_at => "1990-02-01 18:30:35 UTC", :unit_price => "44000"})
    assert_equal Time.parse("1990-02-01 18:30:35 UTC"), result.created_at
  end

  def test_it_can_return_normal_time_for_updated_at
    result = Item.new({:updated_at => "1989-11-03 04:31:14 UTC", :unit_price => "100"})
    assert_equal Time.parse("1989-11-03 04:31:14 UTC"), result.updated_at
  end

  def test_it_converts_updated_at_string_into_real_time
    assert_equal Time.parse("2016-01-11 18:30:35 UTC"), item.updated_at
  end

  def test_it_has_no_unit_price
    skip
    result = Item.new({:unit_price => ""})
    assert_equal 0.0, result.unit_price_to_dollars(result)
  end

end
