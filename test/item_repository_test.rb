require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new('./data/items_short.csv', self)

    assert_instance_of ItemRepository, ir
  end

  def test_it_initializes_with_populated_array
    ir = ItemRepository.new('./data/items_short.csv', self)

    assert_equal 10, ir.items.count
  end

  def test_it_can_return_all_items
    ir = ItemRepository.new('./data/items_short.csv', self)

    target = ir.all

    assert_equal Array, target.class
    assert_equal 10, target.count
  end

  def test_it_can_find_by_id
    ir = ItemRepository.new('./data/items_short.csv', self)

    target = ir.find_by_id(263395237)
    target_2 = ir.find_by_id(00000000)

    assert_equal "510+ RealPush Icon Set", target.name
    assert_nil target_2
  end

  def test_it_can_find_by_name
    ir = ItemRepository.new('./data/items_short.csv', self)

    target = ir.find_by_name("510+ RealPush Icon Set")
    target_2 = ir.find_by_name("510+ realpush icon set")
    target_3 = ir.find_by_name("Not a name")

    assert_equal "510+ RealPush Icon Set", target.name
    assert_equal "510+ RealPush Icon Set", target_2.name
    assert_nil target_3
  end

  def test_it_can_find_all_with_description
      ir = ItemRepository.new('./data/items.csv', self)

      target = ir.find_all_with_description("chunky")
      target_2 = ir.find_all_with_description("ChuNky")
      target_3 = ir.find_all_with_description("Not a name")

      assert_equal "Minty Green Knit Crochet Infinity Scarf", target.last.name
      assert_equal "Minty Green Knit Crochet Infinity Scarf", target_2.last.name
      assert_equal [], target_3
  end

  def test_it_can_find_all_by_price
    ir = ItemRepository.new('./data/items_short.csv', self)

    target = ir.find_all_by_price(12.00)
    target_2 = ir.find_all_by_price(99999.99)

    assert_equal "510+ RealPush Icon Set", target[0].name
    assert_equal Array, target.class
    assert_equal [], target_2
  end

  def test_it_can_find_all_by_price_in_range
    ir = ItemRepository.new('./data/items_short.csv', self)

    target = ir.find_all_by_price_in_range(12.00..13.00)
    target_2 = ir.find_all_by_price_in_range(1125.00..1126.00)

    assert_equal "510+ RealPush Icon Set", target[0].name
    assert_equal Array, target.class
    assert_equal 2, target.count
    assert_equal [], target_2
  end

  def test_it_can_find_all_by_merchant_id
    ir = ItemRepository.new('./data/items_short.csv', self)

    target = ir.find_all_by_merchant_id(12334141)
    target_2 = ir.find_all_by_merchant_id("0")

    assert_equal "510+ RealPush Icon Set", target[0].name
    assert_equal Array, target.class
    assert_equal [], target_2
  end

end