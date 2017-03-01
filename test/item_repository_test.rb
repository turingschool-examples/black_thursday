require './test/test_helper'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists2
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_instance_of ItemRepository, ir
  end

  def test_has_method_all
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_instance_of Array, ir.all
  end

  def test_find_by_id
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items
    
    assert_equal "Glitter scrabble frames", ir.find_by_id(263395617).name
    assert_nil ir.find_by_id(263355617)
  end

  def test_find_by_name
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_equal 263395617, ir.find_by_name("Glitter scrabble frames").id
    assert_nil ir.find_by_name("banana")
  end

  def test_find_all_with_description
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_equal Array, ir.find_all_with_description("glitter").class
    assert_equal 2, ir.find_all_with_description("glitter").length
    assert_equal [], ir.find_all_with_description("banana")
  end

  def test_find_all_by_price
    se = SalesEngine.new({:items => './test/fixtures/items_same_price.csv'})
    ir = se.items

    assert_equal Array, ir.find_all_by_price(BigDecimal.new(13)).class
    assert_equal 2, ir.find_all_by_price(BigDecimal.new(13)).length
    assert_equal [], ir.find_all_by_price(BigDecimal.new(123))
  end

  def test_find_all_by_price_in_range
    se = SalesEngine.new({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_equal Array, ir.find_all_by_price_in_range(13.00..14.00).class
    assert_equal 2, ir.find_all_by_price_in_range(13.00..14.00).length
    assert_equal [], ir.find_all_by_price_in_range(15.00..16.00)
  end

  def test_it_finds_all_by_merchant_id
    se = SalesEngine.new({:items => './test/fixtures/items_same_merchant_id.csv'})
    ir = se.items

    assert_equal Array, ir.find_all_by_merchant_id(12334185).class
    assert_equal 3, ir.find_all_by_merchant_id(12334185).length
    assert_equal [], ir.find_all_by_merchant_id(12234145)
  end

  def test_parent_is_instance_of_sales_engine
    se = SalesEngine.from_csv({:items => './test/fixtures/items_three.csv'})
    ir = se.items

    assert_instance_of SalesEngine, ir.parent
  end

  def test_find_merchant
    se = SalesEngine.from_csv({:items => './test/fixtures/items_same_merchant_id.csv', :merchants => './test/fixtures/merchant_matches.csv'})
    ir = se.items

    assert_equal Merchant, ir.find_merchant(12334185).class
    assert_equal "Madewithgitterxx", ir.find_merchant(12334185).name
  end
end