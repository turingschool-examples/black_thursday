require './test/test_helper'
require './lib/sales_analyst'

class ItemAnalystTest < Minitest::Test

  def test_it_can_find_the_total_number_of_items
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ia = SalesAnalyst.new(se).item_analyst

    assert_equal 20, ia.all_items.length

  end

  def test_it_can_find_the_standard_deviation_of_item_price
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ia = SalesAnalyst.new(se).item_analyst

    assert_equal 224.97, ia.average_price_standard_deviation
  end

  def test_it_can_find_golden_items
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    ia = SalesAnalyst.new(se).item_analyst

    assert_equal 1, ia.golden_items.length
  end

end
