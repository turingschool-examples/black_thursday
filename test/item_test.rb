require "minitest/autorun"
require "minitest/pride"
require "./lib/item"
require "./lib/item_repository"

class ItemTest < Minitest::Test

  def test_item_id_is_an_integer
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    item1 = ir.all[0]

    assert item1.id.kind_of?(Fixnum)
  end

  def test_merchant_id_is_an_integer
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    item1 = ir.all[0]

    assert item1.merchant_id.kind_of?(Fixnum)
  end

  def test_created_at_is_a_time_object
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    item1 = ir.all[0]

    assert item1.created_at.kind_of?(Time)
  end

  def test_updated_at_is_a_time_object
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    item1 = ir.all[0]

    assert item1.updated_at.kind_of?(Time)
  end

  def test_unit_price_is_bigdecimal_class
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    item1 = ir.all[0]

    assert item1.unit_price.kind_of?(BigDecimal)
  end

  def test_unit_price_to_dollars_is_float
    csv_filepath = "./data/items_small.csv"
    ir = ItemRepository.new(csv_filepath)

    dollars_price = ir.all[0].unit_price_to_dollars

    assert dollars_price.kind_of?(Float)
  end

end
