require './test/test_helper'
require './lib/item_repository'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  include TestSetup
  
  def setup
    @se = @@se
    @ir = @@se.items
  end

  def test_it_exists
    assert_instance_of ItemRepository, @se.items
  end

  def test_can_make_new_items
    assert_instance_of Item, @ir.all.first
  end

  def test_returns_all_items
    assert_equal 1367, @ir.all.count
  end

  def test_find_by_id
    assert_equal "Cache cache à la plage", @ir.find_by_id(263396255).name
    assert_nil @ir.find_by_id(00000000)
  end

  def test_find_by_name
    assert_equal 263396255, @ir.find_by_name("Cache cache à la plage").id
    assert_nil @ir.find_by_name("FizzBazBang")
  end

  def test_find_all_with_description
    assert_equal [], @ir.find_all_with_description("poopmuffin")
    assert_equal 263396209, @ir.find_all_with_description("crumpling").first.id
    assert_nil @ir.find_all_with_description("poopmuffin").first
    assert_equal 101, @ir.find_all_with_description("black").count
  end

  def test_find_all_by_price
    assert_equal 12.0, @ir.find_all_by_price(12).first.unit_price
    assert_equal 48, @ir.find_all_by_price(30).count
    assert_equal [], @ir.find_all_by_price(9898989)
    refute @ir.find_all_by_price(9898989).first

    # price = BigDecimal.new(300)
    # assert_equal 5, @se.items.find_all_by_price(price)
  end

  ### This is as far on the spec as I got for item_repository

  def test_find_all_by_price_in_range
    assert_equal 50, @ir.find_all_by_price_in_range(11..12.50).count
    assert_instance_of Array, @ir.find_all_by_price_in_range(150..400)
    assert_nil @ir.find_all_by_price_in_range(0..0).first
  end

  def test_find_all_by_merchant_id
    results = @ir.find_all_by_merchant_id(12334185)
    assert_includes "Glitter scrabble frames", results.first.name
    assert_instance_of Array, results
    assert_equal 6, results.count
    assert_nil @ir.find_all_by_merchant_id(000000).first
  end

end
