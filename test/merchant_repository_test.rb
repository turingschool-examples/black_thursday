require './test/test_helper'
require './lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  def test_it_creates_an_array
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    mr = se.merchants
    assert_equal true, mr.all.is_a?(Array)
  end

  def test_it_populates_the_correct_number_of_merchants
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    mr = se.merchants
    assert_equal 100, mr.all.length
  end

  def test_it_can_find_a_merchant_by_its_id
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    mr = se.merchants

    assert_equal "FlyingLoaf", mr.find_by_id(12334266).name
  end

  def test_it_returns_nil_for_invalid_ids
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    mr = se.merchants

    assert_equal nil, mr.find_by_id(99999999)
  end

  def test_it_can_find_a_merchant_by_its_name
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    mr = se.merchants

    assert_equal 12334266, mr.find_by_name("FlyingLoaf").id
  end

  def test_the_name_search_is_not_case_sensitive
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    mr = se.merchants

    assert_equal 12334266, mr.find_by_name("fLyInGlOaF").id
  end

  def test_it_returns_nil_for_invalid_names
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    mr = se.merchants

    assert_equal nil, mr.find_by_name("WEEOOOWEEEOOOWEEOOO")
  end

  def test_find_all_by_name_returns_an_array
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    mr = se.merchants

    assert_equal [], mr.find_all_by_name("AHAHAHAHAHAHAHAHAHAH")
  end

  def test_it_can_find_multiple_merchants_by_part_of_a_name
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    mr = se.merchants

    assert_equal 4, mr.find_all_by_name("design").length
  end

end
