require './test/test_helper'
require './lib/item_repository'


class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of ItemRepository, ir
  end

  def test_it_has_items
    ir = ItemRepository.new("./data/items.csv")
    assert_equal 1367, ir.all.count

    assert_equal "263395237", ir.all.first.id
  end

  def test_it_can_find_item_by_id
    ir = ItemRepository.new("./data/items.csv")

    actual = ir.find_by_id("263395237")

    assert_instance_of Item, actual
    assert_equal "510+ RealPush Icon Set", actual.name
    assert_equal "263395237", actual.id
  end

  def test_returns_nil_when_no_match_is_found
    ir = ItemRepository.new("./data/items.csv")

    actual = ir.find_by_id(99999)

    assert_nil actual
  end

  def test_it_can_find_item_by_name
    ir = ItemRepository.new("./data/items.csv")

    actual = ir.find_by_name("510+ RealPush Icon Set")[0]

    assert_instance_of Item, actual
    assert_equal "510+ RealPush Icon Set", actual.name
    assert_equal "263395237", actual.id
  end

  def test_it_can_find_all_with_description
    ir = ItemRepository.new("./data/items.csv")
    expected = [ir.all[0]]

    assert_equal expected, ir.find_all_with_description("google")
    assert_equal [], ir.find_all_with_description("This doesn't exist")

  end


end
