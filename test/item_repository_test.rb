require './test/test_helper'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def test_it_creates_an_array
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items
    assert_equal true, ir.all.is_a?(Array)
  end

  def test_it_populates_the_correct_number_of_items
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items
    assert_equal 20, ir.all.length
  end

  


end
