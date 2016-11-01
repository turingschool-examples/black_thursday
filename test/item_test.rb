require './test/test_helper'
require './lib/item'


class ItemTest < Minitest::Test
  attr_reader :item, :item_empty
  def setup
    @item = Item.new({:id => "4",
                      :name => "Thing",
                      :description => "description of the thing",
                      :unit_price => "1200",
                      :merchant_id => "01",
                      :created_at => "2016-01-11 18:30:35 UTC",
                      :updated_at => "2016-01-11 18:30:35 UTC"
                      })
    @item_empty = Item.new({:id => "",
                      :name => "",
                      :description => "",
                      :unit_price => "",
                      :merchant_id => "",
                      :created_at => "",
                      :updated_at => ""
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

  def test_it_can_return_the_merchants_id
    assert_equal Fixnum, item.merchant_id.class
  end

  def test_find_unit_price
    assert_equal BigDecimal, item.unit_price.class
  end

  def test_it_turns_into_a_float
    assert_equal Float, item.unit_price_to_dollars("1200").class
  end

  def test_it_returns_a_number_at_the_end
    result = BigDecimal.new("1200")
    assert_equal Float, item.unit_price_to_dollars(result).class
  end

  def test_it_converts_a_string_into_the_time
    time = Time.parse("2016-01-11 18:30:35 UTC")
    assert_equal time, item.created_at
  end

  def test_it_converts_updated_at_string_into_real_time
    time = Time.parse("2016-01-11 18:30:35 UTC")
    assert_equal time, item.updated_at
  end

  def test_it_returns_the_current_time_if_no_time_is_in_csv_file
    time = Time.new(0)
    assert_equal time, item_empty.created_at
  end

  def test_it_has_no_unit_price
    result = item_empty.unit_price
    assert_equal 0.0, item_empty.unit_price_to_dollars(result)
  end
end
