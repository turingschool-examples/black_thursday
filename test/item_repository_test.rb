require './lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'

class ItemRepositoryTest < Minitest::Test

  def test_repository_stored_as_array
    a = SalesEngine.new
    assert_equal a.item_repository.all.class, Array
  end

  def test_each_item_stores_a_hash
    a = SalesEngine.new
    assert_equal a.item_repository.all[0].class, Hash
  end

  def test_find_by_id_returns_expected_item
    a = SalesEngine.new
    assert_equal a.item_repository.find_by_id("263395721")["name"], "Disney scrabble frames"
  end

  def test_find_all_by_merchant_id_returns_expected_item
    a = SalesEngine.new
    assert_equal a.item_repository.find_all_by_merchant_id("12334185")[0]["name"], "Glitter scrabble frames"
  end

  def test_find_all_by_merchant_id_returns_array
    a = SalesEngine.new
    assert_equal a.item_repository.find_all_by_merchant_id("12334185").class, Array
  end

  def test_find_all_with_description_returns_array
    a = SalesEngine.new
    assert_equal a.item_repository.find_all_with_description("an").class, Array
  end

  def test_find_all_with_description_returns_expected_item
    a = SalesEngine.new
    assert_equal a.item_repository.find_all_with_description("any colour glitter")[0]["name"], "Glitter scrabble frames"
  end

  def test_find_all_by_price_in_range_returns_array
    a = SalesEngine.new
    assert_equal a.item_repository.find_all_by_price_in_range(1..100).class, Array
  end

  def test_find_all_by_price_in_range_returns_expected_item
    a = SalesEngine.new
    assert_equal a.item_repository.find_all_by_price_in_range(1..100)[1]["name"], "OLIVE SOAP"
  end

  def test_find_all_by_price_returns_array
    a = SalesEngine.new
    assert_equal a.item_repository.find_all_by_price("600").class, Array
  end

  def test_find_all_by_price_returns_expected_item
    a = SalesEngine.new
    assert_equal a.item_repository.find_all_by_price("600")[1]["name"], "Bangle Bracelets"
  end

  def test_find_by_name_returns_expected_value
    a = SalesEngine.new
    assert_equal a.item_repository.find_by_name("Bangle Bracelets")["id"], "263430985"
  end

  def test_find_all_by_name_returns_array
    a = SalesEngine.new
    assert_equal a.item_repository.find_all_by_name("ar").class, Array
  end

  def test_find_all_by_name_returns_expected_value
    a = SalesEngine.new
    assert_equal a.item_repository.find_all_by_name("lets")[1]["name"], "Bangle Bracelets"
  end
  
end