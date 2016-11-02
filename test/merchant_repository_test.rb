require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  def test_it_creates_an_array
    se = SalesEngine.from_csv({ :items => "./fixture/items.csv", :merchants => "./fixture/merchant_test_file.csv" })
    mr = se.merchants

    assert_equal Array, mr.all.class
  end

  def test_it_has_the_correct_number_of_merchants
    se = SalesEngine.from_csv({ :items => "./fixture/items.csv", :merchants => "./fixture/merchant_test_file.csv" })
    mr = se.merchants

    assert_equal 2, mr.all.length
  end

  def test_it_can_find_by_merchant_id
    se = SalesEngine.from_csv({ :items => "./fixture/items.csv", :merchants => "./fixture/merchant_test_file.csv" })
    mr = se.merchants

    assert_equal "Shopin1901", mr.id("1234105").name
    assert_equal "Candisart", mr.id("12334112").name
  end

  def test_returns_nil_if_no_id_match
    se = SalesEngine.from_csv({ :items => "./fixture/items.csv", :merchants => "./fixture/merchant_test_file.csv" })
    mr = se.merchants

    refute mr.id("12345678")
  end

  def test_it_can_find_merchant_by_name
    se = SalesEngine.from_csv({ :items => "./fixture/items.csv", :merchants => "./fixture/merchant_test_file.csv" })
    mr = se.merchants

    assert_equal ("12334105"), mr.find_by_name("Shopin1901").id
    assert_equal ("12334112"), mr.find_by_name("Candisart").id
  end

  def test_returns_nil_if_no_name_match
    se = SalesEngine.from_csv({ :items => "./fixture/items.csv", :merchants => "./fixture/merchant_test_file.csv" })
    mr = se.merchants

    refute mr.find_by_name("Amazon").id
  end

  def test_it_can_find_merchant_id_by_case_insensitive_name
    se = SalesEngine.from_csv({ :items => "./fixture/items.csv", :merchants => "./fixture/merchant_test_file.csv" })
    mr = se.merchants

    assert_equal ("12334105"), mr.find_by_name("SHOPIN1901").id
    assert_equal ("12334105"), mr.find_by_name("shopin1901").id
    assert_equal ("12334105"), mr.find_by_name("sHOPin1901").id
    assert_equal ("12334112"), mr.find_by_name("CANDISART").id
    assert_equal ("12334112"), mr.find_by_name("candisart").id
    assert_equal ("12334112"), mr.find_by_name("CANDIisart").id
  end

  def test_it_can_find_all_by_name_returns_an_array
    se = SalesEngine.from_csv({ :items => "./fixture/items.csv", :merchants => "./fixture/merchant_test_file.csv" })
    mr = se.merchants

    assert_equal [], mr.find_all_by_name("Amazon")
    assert_equal ["Shopin1901"], mr.find_all_by_name("1901")
  end

  def test_it_can_find_merchants_by_partial_name
    se = SalesEngine.from_csv({ :items => "./fixture/items.csv", :merchants => "./fixture/merchant_test_file.csv" })
    mr = se.merchants

    assert_equal 0, mr.find_all_by_name("Amazon").length
    assert_equal 1, mr.find_all_by_name("Shop").length
    assert_equal 1, mr.find_all_by_name("art").length
  end

  def test_it_can_find_merchants_by_case_insensitive_partial_name
    se = SalesEngine.from_csv({ :items => "./fixture/items.csv", :merchants => "./fixture/merchant_test_file.csv" })
    mr = se.merchants

    assert_equal 0, mr.find_all_by_name("AMAZON").length
    assert_equal 1, mr.find_all_by_name("shop").length
    assert_equal 1, mr.find_all_by_name("SHOP").length
    assert_equal 1, mr.find_all_by_name("sHOp").length
  end

end
