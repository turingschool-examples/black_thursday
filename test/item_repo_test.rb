require './test/test_helper'
require_relative '../lib/item_repo'

class ItemRepoTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = ItemRepo.new("./data/item_fixtures.csv")
  end

  def test_it_exists
    assert_instance_of ItemRepo, ir
  end

  def test_it_finds_all_items
    assert_equal 2, ir.all.count
  end

  def test_it_can_find_by_id
    expected = "510+ RealPush Icon Set"
    assert_instance_of Item, ir.find_by_id(263395237)
    assert_equal expected, ir.find_by_id(263395237).name
  end

  def test_it_can_find_by_desc
    expected = "510+ RealPush Icon Set"
    sub_str = "You&#39;ve got a total socialmedia iconset!"
    assert_equal expected, ir.find_by_description(sub_str).name
  end

  def test_it_can_find_item_by_price
    expected = "510+ RealPush Icon Set"
    assert_equal expected, ir.find_by_price(1200).name
  end

  def test_it_can_find_all_by_price_in_range
    range = (1100..1400)
    assert_equal 2, ir.find_all_by_price_in_range(range).count
  end

  def test_it_can_find_item_by_merchant_id
    expected = "510+ RealPush Icon Set"
    assert_equal expected, ir.find_by_merchant_id(12334141).name
  end
end
