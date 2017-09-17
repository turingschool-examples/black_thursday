require 'minitest/autorun'
require 'minitest/pride'
require './lib/items_repo'

class ItemRepoTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = ItemRepo.new("./data/items_fixture.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepo, ir
  end

  def test_find_by_name
    assert_equal Item, ir.find_by_name("Custom Hand Made Miniature Bicycle").class
    assert_nil ir.find_by_id(5)
  end

  def test_it_finds_all_items
    assert_equal 1367, ir.all_items
  end

  def test_it_can_find_by_id
    expected = "510+ RealPush Icon Set"
    assert_instance_of Item, ir.find_by_id(263395237)
    assert_equal expected, ir.find_by_id(263395237).name
  end

  def test_it_can_find_by_desc
    expected = "510+ RealPush Icon Set"
    sub_str = "You&#39;ve got a total socialmedia iconset!"
    assert_equal expected, ir.find_all_with_description(sub_str)[0].name
  end

  def test_it_can_find_items_by_price
    expected = "510+ RealPush Icon Set"
    assert_equal expected, ir.find_all_by_price(12)[0].name
  end

  def test_it_can_find_all_by_price_in_range
    range = (11..14)
    assert_equal 76, ir.find_all_by_price_in_range(range).count
  end

  def test_it_returns_empty_array_for_invalid_price_range
    assert_equal [], ir.find_all_by_price_in_range(0..0)
  end

  def test_it_can_find_items_by_merchant_id
    expected = "510+ RealPush Icon Set"
    assert_equal expected, ir.find_all_by_merchant_id(12334141)[0].name
  end

end
