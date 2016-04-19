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

end
