require 'bigdecimal'
require './lib/item_repository'
require './lib/sales_engine'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class ItemRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })
    @ir = @se.item
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_can_return_array_of_known_merchant_instances
    assert_equal 1367, @ir.all.count
  end

  def test_find_by_id
    assert_instance_of Item, @ir.find_by_id(263395237)
    assert_nil @ir.find_by_id("128095803")
  end

  def test_find_by_name
    assert_instance_of Item, @ir.find_by_name("Glitter scrabble frames")
    assert_nil @ir.find_by_name("akfhiauywoiioaw")
  end

  def test_find_all_with_description
    assert_equal 1, @ir.find_all_with_description("livejournal").count
    assert_equal 70, @ir.find_all_with_description("live").count
    assert_equal [], @ir.find_all_with_description("afkjhkhkuah")
  end

  def test_find_all_by_price
    assert_equal 41, @ir.find_all_by_price(1200).count
    assert_equal [], @ir.find_all_by_price(129836587628)
  end

  def test_find_all_by_price_range
    assert_equal 274, @ir.find_all_by_price_range(1200..2400).count
    assert_equal [], @ir.find_all_by_price_range(1983658762..29387598268762)
  end

  def test_find_all_by_merchant_id
    assert_equal 6, @ir.find_all_by_merchant_id(12334185).count
    assert_equal [], @ir.find_all_by_merchant_id(6546546546)

  end

end
