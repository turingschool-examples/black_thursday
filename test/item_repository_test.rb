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

  def test_it_can_find_an_item_by_its_id
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal "Glitter scrabble frames", ir.find_by_id(263395617).name
  end

  def test_it_returns_nil_for_invalid_ids
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal nil, ir.find_by_id(99999999)
  end

  def test_it_can_find_an_item_by_an_integer_id
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal "Glitter scrabble frames", ir.find_by_id(263395617).name
  end

  def test_it_can_find_an_item_by_its_name
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal 263395617, ir.find_by_name("Glitter scrabble frames").id
  end

  def test_the_name_search_is_not_case_sensitive
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal 263395617, ir.find_by_name("gLiTtEr sCraBbLe FrAmEs").id
  end

  def test_it_returns_nil_for_invalid_names
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal nil, ir.find_by_name("WEEOOOWEEEOOOWEEOOO")
  end

  def test_find_all_by_description_returns_an_array
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal [], ir.find_all_with_description("AHAHAHAHAHAHAHAHAHAH")
  end

  def test_it_can_find_multiple_items_by_part_of_a_description
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal 2, ir.find_all_with_description("blue").length
  end

  def test_find_all_by_price_returns_an_array
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal [], ir.find_all_by_price("9999999999999")
  end

  def test_it_can_find_multiple_items_by_price
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal 2, ir.find_all_by_price("2390").length
  end

  def test_find_all_by_price_in_range_returns_an_array
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal [], ir.find_all_by_price_in_range("9999999999998".."9999999999999")
  end

  def test_it_can_find_multiple_items_by_a_range_of_prices
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal 3, ir.find_all_by_price_in_range(12..14).length
  end

  def test_find_all_by_merchant_id_returns_an_array
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal [], ir.find_all_by_merchant_id(99999999)
  end

  def test_find_all_by_merchant_id_returns_an_array
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    ir = se.items

    assert_equal 3, ir.find_all_by_merchant_id(12334185).length
  end

end
