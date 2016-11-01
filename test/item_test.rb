require './test/test_helper'
require './lib/item'


class ItemTest < Minitest::Test
  attr_reader :item
  def setup
    @item = Item.new({:id => 4,
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

  def test_find_unit_price
    assert_equal BigDecimal, item.find_unit_price("1200").class
    # binding.pry
  end

  def test_it_turns_into_a_float
    assert_equal Float, item.unit_price_to_dollars("1200").class
  end

  def test_it_returns_a_number_at_the_end
    result = BigDecimal.new("1200 ")
    assert_equal Float, item.unit_price_to_dollars(result).class
  end

  def test_it_converts_a_string_into_the_time
    assert_equal Time.parse("2016-01-11 18:30:35 UTC"), item.created_at
  end

  def test_it_converts_updated_at_string_into_real_time
    assert_equal Time.parse("2016-01-11 18:30:35 UTC"), item.updated_at
  end

  def test_it_has_no_unit_price
    
  end

end
