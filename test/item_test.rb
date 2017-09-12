require "./test/test_helper"
require "./lib/item"

class ItemTest < Minitest::Test

  attr_reader :item

  def setup
    @item = Item.new(1,
                    "Pencil",
                    "You can use it to write things",
                    BigDecimal.new(10.99,4),
                    11,
                    12,
                    2)
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_item_has_id
    assert_equal 1, item.id
  end

  def test_item_has_a_name
    assert_equal "Pencil", item.name
  end

  def test_item_has_a_description
    assert_equal "You can use it to write things", item.description
  end

  def test_item_has_a_unit_price
    assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  def test_item_has_created_at_time
    assert_equal 11, item.created_at
  end

  def test_item_has_updated_at_time
    assert_equal 12, item.updated_at
  end

  def test_item_has_merchant_id
    assert_equal 2, item.merchant_id
  end

  def test_unit_price_to_dollars_converts_to_float
    assert_equal 10.99, item.unit_price_to_dollars(BigDecimal.new(10.99,4))
  end

  def test_it_loads_single_row_csv
    file_path = "/Users/annalewis/turing/1module/projects/black_thursday/test/test_data/item_single.csv"
    csv_row = CSV.read(file_path, headers: true, header_converters: :symbol)
    item = Item.load_csv(csv_row)

    assert_instance_of Item, Item.load_csv(csv_row)
    assert_equal ["263395617"], item.id
    assert_equal ["Glitter scrabble frames"], item.name
    assert_equal ["Glittery"], item.description
    assert_equal ["1300"], item.unit_price
    assert_equal ["2016-01-11 11:51:37 UTC"], item.created_at
    assert_equal ["1993-09-29 11:56:40 UTC"], item.updated_at
    assert_equal ["12334185"], item.merchant_id

  end

end
