require './test/test_helper'
require './lib/item'
require 'csv'

class ItemTest < Minitest::Test
  attr_reader :item_rows, :item_1

  def setup
    fixture = CSV.open('./test/fixtures/items_fixture.csv', headers:true, header_converters: :symbol)
    @item_rows = fixture.to_a
    @item_1 = Item.new(item_rows[0])
  end

  def test_item_has_a_name
    assert_equal "name a", item_1.name
  end

  def test_item_has_string_name_and_description
    assert_equal "name a", item_1.name
    assert_equal "description a", item_1.description
  end

  def test_item_has_fixnum_ids
    assert_equal 1, item_1.id
    assert_equal 1000, item_1.merchant_id
  end

  def test_item_has_time_objects
    assert_instance_of Time, item_1.created_at
    assert_instance_of Time, item_1.updated_at
  end

  def test_item_has_big_decimal_object
    assert_instance_of BigDecimal, item_1.unit_price
  end

  def test_method_unit_price_to_dollars_returns_its_float
    assert 1.0, item_1.unit_price_to_dollars
  end

  def test_method_merchant_queries_item_parent
    mock_ir = Minitest::Mock.new
    item = Item.new(item_rows[0], mock_ir)
    mock_ir.expect(:find_merchant_by_id, nil, [1000])
    item.merchant
    assert mock_ir.verify
  end
end
