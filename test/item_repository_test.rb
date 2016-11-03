require './lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'

class ItemRepositoryTest < Minitest::Test

  def setup 
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})
    @ir = se.items
  end

  def test_repository_stored_as_array
    assert_equal Array, @ir.all.class
  end

  def test_each_item_stores_an_item_object
    assert_equal Item, @ir.all[0].class
  end

  def test_find_by_id_returns_expected_item
    assert_equal "Disney scrabble frames", @ir.find_by_id(263395721).name
  end

  def test_find_all_by_merchant_id_returns_expected_item
    assert_equal "Glitter scrabble frames", @ir.find_all_by_merchant_id(12334185)[0].name
  end

  def test_find_all_by_merchant_id_returns_array
    assert_equal Array, @ir.find_all_by_merchant_id(12334185).class
  end

  def test_find_all_with_description_returns_array
    assert_equal Array, @ir.find_all_with_description("an").class
  end

  def test_find_all_with_description_returns_expected_item
    assert_equal "Glitter scrabble frames", @ir.find_all_with_description("any colour glitter")[0].name
  end

  def test_find_all_by_price_in_range_returns_array
    assert_equal Array, @ir.find_all_by_price_in_range(1..100).class
  end

  def test_find_all_by_price_in_range_returns_expected_item
    assert_equal "Glitter scrabble frames", @ir.find_all_by_price_in_range(1..100)[1].name
  end

  def test_find_all_by_price_returns_array
    assert_equal Array, @ir.find_all_by_price(600).class
  end

  def test_find_all_by_price_returns_expected_item
    assert_equal "Les raisons", @ir.find_all_by_price(600)[1].name
  end

  def test_find_by_name_returns_expected_value
    assert_equal 263430985, @ir.find_by_name("Bangle Bracelets").id
  end

  def test_find_all_by_name_returns_array
    assert_equal Array, @ir.find_all_by_name("ar").class
  end

  def test_find_all_by_name_returns_expected_value
    assert_equal @ir.find_all_by_name("lets")[1].name, "Bangle Bracelets"
  end
  
end